//
//  ContentView.swift
//  TuneIn
//
//  Created by Jessica Ying on 2025-03-30.
//

import SwiftUI

struct ContentView: View {
    let user: User // Accepting an User object
    
    var body: some View {
        TabView {
            FunctionsView()
            .padding()
            .tabItem {
                Label("Functions", systemImage: "music.quarternote.3")
            }
            ProfileView(user: user)
            .padding()
            .tabItem {
                Label("Profile", systemImage: "person.circle")
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

    return ContentView(user: dummyUser)
}
