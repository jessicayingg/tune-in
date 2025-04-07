//
//  ProfileViewViewModel.swift
//  TuneIn
//
//  Created by Jessica Ying on 2025-04-01.
//
// This is for finding all data related to components that need to be displayed in ProfileView

import Foundation

class ProfileViewViewModel: ObservableObject {
    
    // This function gets a user's top artist from Spotify
    func fetchTopArtist(accessToken: String, completion: @escaping ([Artist]?) -> Void) {
        let url = URL(string: "https://api.spotify.com/v1/me/top/artists?time_range=long_term&limit=1&offset=0")!
        var request = URLRequest(url: url)
        
        // Set the Authorization header with the Bearer token
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        // Request our request from Spotify
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching recent tracks: \(error)")
                completion(nil)
                return
            }
            
            // Parse the response
            if let data = data {
                // Print the raw response to debug
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Raw response: \(jsonString)")
                }
                
                do {
                    let decoder = JSONDecoder()
                    // Decode into a list of Artists (TopArtistsResponse)
                    let topArtistResponse = try decoder.decode(TopArtistsResponse.self, from: data)
                    completion(topArtistResponse.items)
                } catch {
                    print("Error decoding recent artist: \(error)")
                    completion(nil)
                }
            }
        }.resume()
    }
    
    // This function gets a user's top song from Spotify
    func fetchTopTrack(accessToken: String, completion: @escaping ([Track]?) -> Void) {
        let url = URL(string: "https://api.spotify.com/v1/me/top/tracks?time_range=long_term&limit=1&offset=0")!
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
                } */
                
                do {
                    let decoder = JSONDecoder()
                    // Decode into a list of Tracks (TopTracksResponses)
                    let topTrackResponse = try decoder.decode(TopTracksResponse.self, from: data)
                    completion(topTrackResponse.items)
                } catch {
                    print("Error decoding recent tracks: \(error)")
                    completion(nil)
                }
            }
        }.resume()
    }
 
    // This function gets a user's 3 most recently-played songs from Spotify
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


