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
        VStack {
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
            
            HStack {
                Text("Hi, ")
                    .font(.title)
                
                Text(user.name)
                    .font(.title)
            }
            .padding()
            
            HStack {
                Text("Email: ")
                
                Text(user.email)
            }
            
            VStack {
                Text("Most Listened-To Artist: ")
                
                ForEach(topArtist, id: \.id) { artist in
                    Text(artist.name)
                }
            }
            
            VStack {
                Text("Most Played Song: ")
                
                ForEach(topTrack, id: \.id) { track in
                    HStack {
                        if let imageURL = track.album.images.first?.url,
                           let url = URL(string: imageURL) {
                            AsyncImage(url: url) { image in
                                image.resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                            } placeholder: {
                                Image(systemName: "person.circle")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(Color.blue)
                                    .frame(width: 50, height: 50)
                                    .padding()
                            }
                        }
                        
                        Text(track.name)
                        Text(" - ")
                        Text(track.artists[0].name)
                    }
                }
                
            }
            
            VStack {
                Text("Recently Played Tracks: ")
                
                // For each loop basically
                ForEach(recentTracks, id: \.track.id) { track in
                    HStack {
                        if let imageURL = track.track.album.images.first?.url,
                           let url = URL(string: imageURL) {
                            AsyncImage(url: url) { image in
                                image.resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                            } placeholder: {
                                Image(systemName: "person.circle")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(Color.blue)
                                    .frame(width: 50, height: 50)
                                    .padding()
                            }
                        }
                        
                        Text(track.track.name)
                        Text(" - ")
                        Text(track.track.artists[0].name)
                    }
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

