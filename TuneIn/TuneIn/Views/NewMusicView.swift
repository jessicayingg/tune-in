//
//  NewMusicView.swift
//  TuneIn
//
//  Created by Jessica Ying on 2025-04-06.
//

import SwiftUI

struct NewMusicView: View {
    let user: User
    @StateObject var viewModel = NewMusicViewViewModel()
    @State private var topTracks: [Track] = []
    @State private var topTracksString: String
    
    var body: some View {
        
        VStack {
            Text("Finding new music for you based on your recent listens: ")
            
        }
        .onAppear() {
            guard let accessToken = user.accessToken else {
                print("Access token is nil")
                return
            }
            
            // Get the recent tracks
            viewModel.fetchTopTracks(accessToken: accessToken) {
                tracks in
                if let tracks = tracks {
                    self.topTracks = tracks
                } else {
                    print("No tracks fetched")
                }
            }
            
            topTracksString = viewModel.buildTracksString(tracks: self.topTracks)
            
        }
    }
}
/*
#Preview {
    let dummyUser = User(
        accessToken: "dummy_access_token",
        refreshToken: "dummy_refresh_token",
        tokenExpirationDate: Date().timeIntervalSince1970 + 3600, // 1 hour in the future
        id: "12345",
        name: "Test",
        email: "test@gmail.com",
        profileURL: nil,
        country: "CA",
        subscription: "premium"
    )

    return NewMusicView(user: dummyUser)
}*/
