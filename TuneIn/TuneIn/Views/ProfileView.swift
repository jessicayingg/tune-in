//
//  ProfileView.swift
//  TuneIn
//
//  Created by Jessica Ying on 2025-03-30.
//

import SwiftUI

struct ProfileView: View {
    let user: User
    @StateObject var viewModel = ProfileViewViewModel()
    @State private var topArtist: [Artist] = []
    @State private var topTrack: [Track] = []
    @State private var recentTracks: [RecentTrack] = []
    
    var body: some View {
        ScrollView {
            VStack {
                HStack() {
                    // Profile picture
                    if let profileURL = user.profileURL, let url = URL(string: profileURL) {
                        AsyncImage(url: url) { image in
                            image.resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                        } placeholder: {
                            Image(systemName: "person.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(Color.blue)
                                .frame(width: 125, height: 125)
                                .padding()
                        }
                    } else {
                        Image(systemName: "person.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(Color.blue)
                            .frame(width: 125, height: 125)
                            .padding()
                    }
                    
                    VStack(alignment: .leading) {
                        Text(user.name)
                            .font(.title3)
                            .fontWeight(.bold)
                        Text(user.email)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.leading, 10)
                }
                .frame(width: 350, height: 150)
                .padding()
                
                Divider()
                
                VStack {
                    Text("Most Listened-To Artist: ")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .padding(.bottom, 5)
                    
                    ForEach(topArtist, id: \.id) { artist in
                        ArtistInfoCard(artist: artist)
                    }
                }.padding()
                
                Divider()
                
                VStack {
                    Text("Most Played Song: ")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .padding(.bottom, 5)
                    
                    ForEach(topTrack, id: \.id) { track in
                        TrackInfoCard(track: track)
                    }
                    
                }
                .padding()
                
                Divider()
                
                VStack {
                    Text("Recently Played Tracks: ")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .padding(.bottom, 5)
                    
                    // For each loop basically
                    ForEach(recentTracks, id: \.track.id) { track in
                        RecentTrackInfoCard(recentTrack: track)
                    }
                }
                .padding()
                
            }
            .padding()
            .onAppear {
                guard let accessToken = user.accessToken else {
                    print("Access token is nil")
                    return
                }
                
                // Get the recent tracks
                viewModel.fetchRecentTracks(accessToken: accessToken) {
                    tracks in
                    if let tracks = tracks {
                        self.recentTracks = tracks
                    } else {
                        print("No tracks fetched")
                    }
                }
                
                // Get the top tracks
                viewModel.fetchTopTrack(accessToken: accessToken) {
                    tracks in
                    if let tracks = tracks {
                        self.topTrack = tracks
                    } else {
                        print("No tracks fetched")
                    }
                }
                
                // Get the top artists
                viewModel.fetchTopArtist(accessToken: accessToken) {
                    artists in
                    if let artists = artists {
                        self.topArtist = artists
                    } else {
                        print("No tracks fetched")
                    }
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

    return ProfileView(user: dummyUser)
}

