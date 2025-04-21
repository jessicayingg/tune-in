//
//  NewMusicViewViewModel.swift
//  TuneIn
//
//  Created by Jessica Ying on 2025-04-06.
//
// This is for doing all the AI api-related tasks

import Foundation

class NewMusicViewViewModel: ObservableObject {
    
    // This function gets recommendations from AI (Meta free)
    func fetchAIRecommendations(prompt: String, completion: @escaping (String?) -> Void) {
        guard let url = URL(string: "https://openrouter.ai/api/v1/chat/completions") else {
            print("Invalid URL")
            completion(nil)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(APIConstants.openRouterKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("openrouter-quasar-alpha", forHTTPHeaderField: "HTTP-Referer") // NEED THIS
        request.addValue("https://yourdomain.com", forHTTPHeaderField: "X-Title") // ALSO NEED, but just a placeholder is ok

        // Make the full request to the API
        let requestBody: [String: Any] = [
            "model": "meta-llama/llama-4-scout:free",
            "messages": [
                ["role": "system", "content": "You are a music recommendation engine."], // Initial message
                ["role": "user", "content": prompt] // Message containing the specific task I want it to do
            ]
        ]

        do {
            // Send the request to the API
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody, options: [])
        } catch {
            print("Failed to encode JSON: \(error)")
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            // Error checks
            if let error = error {
                print("Request failed: \(error)")
                completion(nil)
                return
            }
            // Initializing data to be what was received from API
            guard let data = data else {
                print("No data in response")
                completion(nil)
                return
            }

            // Trying to decode the JSON sent by the API
            do {
                
                if let rawJsonString = String(data: data, encoding: .utf8) {
                    print("Raw JSON response: \(rawJsonString)")
                }
                
                if let result = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let choices = result["choices"] as? [[String: Any]],
                   let message = choices.first?["message"] as? [String: Any], // Message has the actual AI-generated text
                   let content = message["content"] as? String {
                    completion(content) // Pass result back up
                } else {
                    print("Unexpected response format")
                    completion(nil)
                }
            } catch {
                print("Failed to parse response JSON: \(error)")
                completion(nil)
            }
        }.resume()
    }
    
    // This function builds the bulk of the prompt for the AI to eventually receive
    func buildAIPrompt(tracksString: String) -> String {
        var result = "Based on these top tracks, recommend 10 Spotify songs this user might like:\n"
        result += "\nTop Tracks:\n"
        result += "\(tracksString)\n"
        result += "Please return the songs as a JSON array with this structure:\n"
        result += "[\n{ \"title\": ..., \"artistName\": ... },\n...]\n" // JSON structure can make it easier to decode
        
        result += "Do not provide any other text. Only provide the JSON array with the given structure."
        
        return result
    }
    
    // This function builds a string containing a user's recent top 10 tracks
    func buildTracksString(tracks: [Track]) -> String {
        var result = ""
        // enumerated() is used to iterate through the array and get both index and tuple
        for (index, track) in tracks.enumerated() {
            // Format: 1. Track - Artist ...
            result += "\(index + 1). \(track.name) - \(track.artists[0].name)\n"
        }
        return result
    }
    
    // This function gets top 10 songs played recently (short term) from Spotify API
    func fetchTopTracks(accessToken: String, completion: @escaping ([Track]?) -> Void) {
        let url = URL(string: "https://api.spotify.com/v1/me/top/tracks?time_range=short_term&limit=10&offset=0")!
        var request = URLRequest(url: url)
        
        // Set the Authorization header with the Bearer token
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        // Request our request from Spotify
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching top tracks: \(error)")
                completion(nil)
                return
            }
            
            // Parse the response
            if let data = data {
                // Print the raw response to debug
                /*
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Raw response: \(jsonString)")
                }*/
                
                do {
                    let decoder = JSONDecoder()
                    // Decode into a list of Tracks (TopTracksResponse)
                    let topTrackResponse = try decoder.decode(TopTracksResponse.self, from: data)
                    completion(topTrackResponse.items)
                } catch {
                    print("Error decoding recent tracks: \(error)")
                    completion(nil)
                }
            }
        }.resume()
    }
    
    
    func getSearchedTrack(urls: [URL], accessToken: String, completion: @escaping ([Track]) -> Void) {
        var foundTracks: [Track] = []
        let dg = DispatchGroup()
        
        for url in urls {
            dg.enter()
            
            var request = URLRequest(url: url)
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                defer { dg.leave() }
                
                guard let data = data
                else {
                    print("No data for url: \(url)")
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(TrackSearchResponse.self, from: data)
                    
                    if let firstTrack = result.tracks.items.first {
                        foundTracks.append(firstTrack)
                        print("Found track: \(firstTrack.name)")
                    } else {
                        print("No tracks found for URL: \(url)")
                    }
                } catch {
                    print("Decoding error: \(error.localizedDescription)")
                }
            }.resume()
        }
        
        dg.notify(queue: .main) {
            completion(foundTracks)
        }
        
    }
    
    func getSongURLs(recommendedTracks: [AIResponseTrack]) -> [URL] {
        // A list of urls to search with
        /*
        // Doing it with strings, better way is url components (shown below)
        let urlList = recommendedTracks.map { track in
            let searchTitle = track.title.replacingOccurrences(of: " ", with: "%20")
            let searchArtist = track.artistName.replacingOccurrences(of: " ", with: "%20")
            let url = URL(string: "https://api.spotify.com/v1/search?q=track:\(searchTitle)%20artist:\(searchArtist)&type=track&limit=1")
            return url
        }
         */
        
        var urlList: [URL] = []
        
        for track in recommendedTracks {
            var components = URLComponents(string: "https://api.spotify.com/v1/search")
            
            // All the parts that come after the q= in the url
            components?.queryItems = [
                URLQueryItem(name: "q", value: "track:\(track.title) artist:\(track.artistName)"),
                URLQueryItem(name: "type", value: "track"),
                URLQueryItem(name: "limit", value: "1")
            ]
            
            if let url = components?.url {
                urlList.append(url)
            }
        }
        
        return urlList
    }
}
