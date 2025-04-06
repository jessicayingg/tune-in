//
//  NewMusicViewViewModel.swift
//  TuneIn
//
//  Created by Jessica Ying on 2025-04-06.
//

import Foundation

class NewMusicViewViewModel: ObservableObject {
    
    func fetchQuasarRecommendations(prompt: String, completion: @escaping (String?) -> Void) {
        guard let url = URL(string: "https://openrouter.ai/api/v1/chat/completions") else {
            print("Invalid URL")
            completion(nil)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(APIConstants.openRouterKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("openrouter-quasar-alpha", forHTTPHeaderField: "HTTP-Referer") // required
        request.addValue("https://yourdomain.com", forHTTPHeaderField: "X-Title") // also required, but can be placeholder

        let requestBody: [String: Any] = [
            "model": "openrouter/quasar-alpha",
            "messages": [
                ["role": "system", "content": "You are a music recommendation engine."],
                ["role": "user", "content": prompt]
            ]
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody, options: [])
        } catch {
            print("Failed to encode JSON: \(error)")
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Request failed: \(error)")
                completion(nil)
                return
            }

            guard let data = data else {
                print("No data in response")
                completion(nil)
                return
            }

            do {
                if let result = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let choices = result["choices"] as? [[String: Any]],
                   let message = choices.first?["message"] as? [String: Any],
                   let content = message["content"] as? String {
                    completion(content)
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
    
    /*
    // The actual GPT calling api
    func fetchOpenAISongRecommendations(prompt: String, completion: @escaping (String?) -> Void) {
        guard let url = URL(string: "https://api.openai.com/v1/chat/completions") else {
            print("Invalid URL")
            completion(nil)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(APIConstants.openAIKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let requestBody: [String: Any] = [
            "model": "gpt-3.5-turbo",
            "messages": [
                ["role": "system", "content": "You are a music recommendation engine. Return songs in clean JSON."],
                ["role": "user", "content": prompt]
            ],
            "temperature": 0.8
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody, options: [])
        } catch {
            print("Failed to encode JSON: \(error)")
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Request failed: \(error)")
                completion(nil)
                return
            }

            guard let data = data else {
                print("No data in response")
                completion(nil)
                return
            }

            do {
                // Try printing the raw string first
                if let rawString = String(data: data, encoding: .utf8) {
                    print("Raw OpenAI response:\n\(rawString)")
                }
                
                if let result = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let choices = result["choices"] as? [[String: Any]],
                   let message = choices.first?["message"] as? [String: Any],
                   let content = message["content"] as? String {
                    completion(content)
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
     */
    
    func buildAIPrompt(tracksString: String) -> String {
        var result = "Based on these top tracks, recommend 10 Spotify songs this user might like:\n"
        result += "\nTop Tracks:\n"
        result += "\(tracksString)\n"
        result += "Please return the songs as a JSON array with this structure:\n"
        result += "[\n{ \"title\": ..., \"artistName\": ... },\n...]"
        
        return result
    }
    
    func buildTracksString(tracks: [Track]) -> String {
        var result = ""
        // enumerated() is used to iterate through the array and get both index and tuple
        print(tracks.count)
        for (index, track) in tracks.enumerated() {
            result += "\(index + 1). \(track.name) - \(track.artists[0].name)\n"
        }
        return result
    }
    
    // Get top 10 songs played recently (short term)
    func fetchTopTracks(accessToken: String, completion: @escaping ([Track]?) -> Void) {
        let url = URL(string: "https://api.spotify.com/v1/me/top/tracks?time_range=short_term&limit=10&offset=0")!
        var request = URLRequest(url: url)
        
        // Set the Authorization header with the Bearer token
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        // Perform the network request
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
                    let topTrackResponse = try decoder.decode(TopTracksResponse.self, from: data)
                    completion(topTrackResponse.items)
                } catch {
                    print("Error decoding recent tracks: \(error)")
                    completion(nil)
                }
            }
        }.resume()
    }
}
