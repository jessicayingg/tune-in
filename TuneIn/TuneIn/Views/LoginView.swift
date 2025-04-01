//
//  LoginView.swift
//  TuneIn
//
//  Created by Jessica Ying on 2025-03-30.
//

import SwiftUI

struct LoginView: View {
    // Stores access token after user logs in
    @State private var accessToken: String? = nil
    
    let clientID = APIConstants.clientId
    let redirectURI = APIConstants.redirectUri
    
    var body: some View {
        VStack() {
            // This is to check if we have the access token
            if let token = accessToken {
                //Text("Access Token: \(token)")  // Display the token if available
                ContentView(accessToken: token)
            } else {
                Text("Tune In")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(50)
                
                Button(action: {
                    loginWithSpotify()
                }) {
                    Text("Login to Spotify")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                }
                .buttonStyle(.bordered)
            }
        }
        // Detects when custom url scheme is opened (tunein://callback)
        .onOpenURL {url in
                handleSpotifyCallback(url)
        }
    }
    
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
            accessToken = token  // Update the state with the access token
        }
    }
}

#Preview {
    LoginView()
}
