//
//  LoginView.swift
//  TuneIn
//
//  Created by Jessica Ying on 2025-03-30.
//

import SwiftUI

struct LoginView: View {
    // Stores access token after user logs in
    @StateObject var viewModel = LoginViewViewModel()
    
    var body: some View {
        VStack() {
            // This is to check if we have the access token
            if let user = viewModel.user {
                //Text("Access Token: \(token)")  // Display the token if available
                ContentView(user: user)
            } else {
                Text("Tune In")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(50)
                
                Button(action: {
                    viewModel.loginWithSpotify()
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
            viewModel.handleSpotifyCallback(url)
        }
        .onAppear() {
            //print(APIConstants.openAIKey)
        }
    }
}

#Preview {
    LoginView()
}
