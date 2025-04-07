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
    @State private var topTracksString: String = ""
    @State private var aiPrompt: String = ""
    @State private var aiRecommendations: [AIResponseTrack] = []
    
    var body: some View {
        
        VStack {
            Text("Finding new music for you based on your recent listens: ")
            Button("Click to discover some new songs!") {
                // Button action: 
                self.topTracksString = viewModel.buildTracksString(tracks: self.topTracks)
                self.aiPrompt = viewModel.buildAIPrompt(tracksString: self.topTracksString)
                print(self.aiPrompt)
                
                viewModel.fetchQuasarRecommendations(prompt: self.aiPrompt) { result in
                    guard let recommendations = result else {
                        print("Failed to get recommendations.")
                        return
                    }
                    
                    print("AI Recommendations:\n\(recommendations)")
                    
                    // decoding the json that the ai recommendation gave us (parsing)
                    if let jsonData = recommendations.data(using: .utf8) {
                        do {
                            self.aiRecommendations = try JSONDecoder().decode([AIResponseTrack].self, from: jsonData)
                            // Now, use songs for stuff!
                            print("Got Songs: \(self.aiRecommendations)")
                        } catch {
                            print("Failed to decode songs: \(error)")
                        }
                    }
                }
            }
            // songs.indices is used to loop with an index
            ForEach(self.aiRecommendations.indices, id: \.self) { index in
                HStack {
                    Text("\(index + 1)")
                    Text(": ")
                    Text(self.aiRecommendations[index].title)
                    Text(" - ")
                    Text(self.aiRecommendations[index].artistName)
                }
            }
            
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
                    print("tracks: ")
                    print(tracks)
                } else {
                    print("No tracks fetched")
                }
            }
        }
    }
}
/*
struct NewMusicView: View {
    let user: User
    @StateObject var viewModel = NewMusicViewViewModel()
    @State private var topTracks: [Track] = []
    @State private var topTracksString: String
    @State private var aiPrompt: String
    
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
            aiPrompt = viewModel.buildAIPrompt(tracksString: topTracksString)
            print(aiPrompt)
        }
    }
}*/

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
}
