//
//  TrendsViewViewModel.swift
//  TuneIn
//
//  Created by Jessica Ying on 2025-04-04.
//

import Foundation

class TrendsViewViewModel: ObservableObject {
 
    func fetchTopTracks(accessToken: String, completion: @escaping ([Track]?) -> Void) {
        let url = URL(string: "https://api.spotify.com/v1/me/top/tracks?limit=10")! // You can adjust the limit as needed
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
                do {
                    let decoder = JSONDecoder()
                    let topTracksResponse = try decoder.decode(TopTracksResponse.self, from: data)
                    completion(topTracksResponse.items)
                } catch {
                    print("Error decoding top tracks: \(error)")
                    completion(nil)
                }
            }
        }.resume()
    }
}


