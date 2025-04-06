//
//  NewMusicViewViewModel.swift
//  TuneIn
//
//  Created by Jessica Ying on 2025-04-06.
//

import Foundation

class NewMusicViewViewModel: ObservableObject {
    
    func buildTracksString(tracks: [Track]) -> String {
        var result = ""
        // enumerated() is used to iterate through the array and get both index and tuple
        for (index, track) in tracks.enumerated() {
            result += "\(index + 1). \(track.name) - \(track.artists[0])\n"
        }
        return result
    }
    /*
    func getTracksDetails(from tracks: [Track]) -> [(name: String, artist: String)] {
        return tracks.map { ($0.name, $0.artists.first?.name ?? "") }
    }*/
    
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
                } */
                
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
