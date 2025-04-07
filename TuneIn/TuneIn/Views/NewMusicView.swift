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
            Button(action: {
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
            }) {
                Text("Find new songs")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .strokeBorder(
                                LinearGradient(
                                    gradient: Gradient(
                                        colors:
                                            [Color.indigo, Color.orange, Color.red]
                                    ),
                                    startPoint: .topLeading, // top left
                                    endPoint: .bottomTrailing // bottom right
                                ),
                                lineWidth: 5 // border width
                            )
                    )
            }
            
            ScrollView {
                // songs.indices is used to loop with an index
                ForEach(self.aiRecommendations.indices, id: \.self) { index in
                    // Some of these are hard-coded, fix the abstraction later
                    let artist = Artist(
                        id: self.aiRecommendations[index].artistName,
                        name: self.aiRecommendations[index].artistName,
                        images: nil)
                    let albumImage = AlbumImage(
                        url: "",
                        height: 640,
                        width: 640)
                    let album = Album(
                        name: "",
                        images: [albumImage])
                    let track = Track(
                        id: self.aiRecommendations[index].title,
                        name: self.aiRecommendations[index].title,
                        artists: [artist],
                        album: album)
                    TrackInfoCard(track: track)
                }
                .frame(maxWidth: .infinity)
                
                // Old For each loop
                /*
                ForEach(self.aiRecommendations.indices, id: \.self) { index in
                    HStack {
                        Text("\(index + 1)")
                        Text(": ")
                        Text(self.aiRecommendations[index].title)
                        Text(" - ")
                        Text(self.aiRecommendations[index].artistName)
                    }
                }*/
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
