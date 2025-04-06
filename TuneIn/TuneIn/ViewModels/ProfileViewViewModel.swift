//
//  ProfileViewViewModel.swift
//  TuneIn
//
//  Created by Jessica Ying on 2025-04-01.
//

import Foundation

class ProfileViewViewModel: ObservableObject {
    

    
    func fetchTopTrack(accessToken: String, completion: @escaping ([Track]?) -> Void) {
        let url = URL(string: "https://api.spotify.com/v1/me/top/tracks?time_range=long_term&limit=1&offset=0")!
        var request = URLRequest(url: url)
        
        // Set the Authorization header with the Bearer token
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        // Perform the network request
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching recent tracks: \(error)")
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
 
    func fetchRecentTracks(accessToken: String, completion: @escaping ([RecentTrack]?) -> Void) {
        let url = URL(string: "https://api.spotify.com/v1/me/player/recently-played?limit=3")!
        var request = URLRequest(url: url)
        
        // Set the Authorization header with the Bearer token
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        // Perform the network request
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching recent tracks: \(error)")
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
                    let recentTracksResponse = try decoder.decode(RecentTracksResponse.self, from: data)
                    completion(recentTracksResponse.items)
                } catch {
                    print("Error decoding recent tracks: \(error)")
                    completion(nil)
                }
            }
        }.resume()
    }
}


