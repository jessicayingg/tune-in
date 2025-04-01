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
/*
#Preview {
    ContentView(user: "Poopy")
}*/
