//
//  LoginViewViewModel.swift
//  TuneIn
//
//  Created by Jessica Ying on 2025-04-01.
//

import Foundation
import SwiftUI

class LoginViewViewModel: ObservableObject {
    // Stores access token after user logs in
    @Published var accessToken: String? = nil
    @Published var user: User? = nil // For storing user details
    
    let clientID = APIConstants.clientId
    let redirectURI = APIConstants.redirectUri
    
    func loginWithSpotify() {
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
    
    func handleSpotifyCallback(_ url: URL) {
        // Spotify will redirect with a fragment (e.g., tunein://callback#access_token=YOUR_ACCESS_TOKEN)
        guard let fragment = url.fragment else { return }
        
        // Split the fragment into key-value pairs
        let params = fragment.components(separatedBy: "&").reduce(into: [String: String]()) { result, param in
            let parts = param.components(separatedBy: "=")
            if parts.count == 2 {
                result[parts[0]] = parts[1]
            }
        }
        
        // Extract the access token
        if let token = params["access_token"] {
            //accessToken = token  // Update the state with the access token
            DispatchQueue.main.async {
                self.fetchUserProfile(token: token)
            }
        }
    }
    
    func fetchUserProfile(token: String) {
        guard let url = URL(string: "https://api.spotify.com/v1/me") else { return }
        
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
                let userResponse = try decoder.decode(SpotifyUserResponse.self, from: data)
                
                DispatchQueue.main.async {
                    self.user = User(
                        accessToken: token,
                        refreshToken: nil,
                        tokenExpirationDate: nil,
                        id: userResponse.id,
                        name: userResponse.displayName,
                        email: userResponse.email,
                        profileURL: userResponse.images.first?.url,
                        // NOTE for future me:
                        // The url shows up as Optional("https://i.scdn.co/image/ab6775700000ee85e7565dbe9932abc47cdf5286")
                        // So I think I will need to trim it
                        country: userResponse.country,
                        // Same thing
                        // Optional("CA")
                        subscription: userResponse.product
                        // Same thing
                        // Optional("premium")
                    )
                    print("User data successfully loaded: \(self.user!)") // Debugging print
                }
            } catch {
                print("Failed to decode user data: \(error)")
            }
        }.resume()
    }

}
