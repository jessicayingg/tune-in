//
//  ProfileView.swift
//  TuneIn
//
//  Created by Jessica Ying on 2025-03-30.
//

import SwiftUI

struct ProfileView: View {
    let user: User
    
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
            
            HStack {
                Text("Most Listened-To Artist: ")
                Text("NAME")
            }
            
            HStack {
                Text("Most Played Song: ")
                Text("SONG-TITLE")
            }
            
            VStack {
                Text("Recently Played Songs: ")
                Button("Wildflower") {
                    
                }
                .buttonStyle(.borderedProminent)
                Button("Wildflower") {
                    
                }
                .buttonStyle(.borderedProminent)
                Button("Wildflower") {
                    
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
            
        }
        .padding()
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

