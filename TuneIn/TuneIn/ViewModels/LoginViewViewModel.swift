//
//  LoginViewViewModel.swift
//  TuneIn
//
//  Created by Jessica Ying on 2025-04-01.
//
// This handles all of the Spotify login logic

import Foundation
import SwiftUI

class LoginViewViewModel: ObservableObject {
    // Stores access token after user logs in
    @Published var user: User? = nil // For storing user details
    
    let clientID = APIConstants.clientId
    let redirectURI = APIConstants.redirectUri
    
    // This function opens the url for the user to log in with Spotify
    func loginWithSpotify() {
        // Using URLComponents to build a url
        var components = URLComponents()
        components.scheme = "https"
        components.host = APIConstants.authHost
        components.path = "/authorize"
        
        components.queryItems = APIConstants.authParams.map { key, value in
            URLQueryItem(name: key, value: value)
        }
        
        if let url = components.url {
            // Open url in Safari
            UIApplication.shared.open(url)
        }
    }
    
    // This function is for when Spotify redirects back to the app
    func handleSpotifyCallback(_ url: URL) {
        // Spotify will redirect with a fragment (ex: tunein://callback#access_token=access_token_i_want)
        guard let fragment = url.fragment else { return }
        
        // Split the fragment into key-value pairs
        let params = fragment.components(separatedBy: "&").reduce(into: [String: String]()) { result, param in
            let parts = param.components(separatedBy: "=")
            if parts.count == 2 {
                result[parts[0]] = parts[1]
            }
        }
        
        // Get the access token
        if let token = params["access_token"] {
            // Get the user's profile using the token
            DispatchQueue.main.async {
                self.fetchUserProfile(token: token)
            }
        }
    }
    
    // This function gets a user's profile from Spotify
    func fetchUserProfile(token: String) {
        guard let url = URL(string: "https://api.spotify.com/v1/me") else { return }
        
        // Use token for request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching user profile: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data received from Spotify API")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                // Use json to try and decode Spotify's response
                let userResponse = try decoder.decode(SpotifyUserResponse.self, from: data)
                
                DispatchQueue.main.async {
                    // Setting up the user variable with all user's information
                    self.user = User(
                        accessToken: token,
                        refreshToken: nil,
                        tokenExpirationDate: nil,
                        id: userResponse.id,
                        name: userResponse.displayName,
                        email: userResponse.email,
                        profileURL: userResponse.images.first?.url,
                        country: userResponse.country,
                        subscription: userResponse.product
                    )
                    print("User data successfully loaded: \(self.user!)") // Debugging print
                }
            } catch {
                print("Failed to decode user data: \(error)")
            }
        }.resume()
    }

}
