//
//  ContentView.swift
//  TuneIn
//
//  Created by Jessica Ying on 2025-03-30.
//

import SwiftUI

struct ContentView: View {
    let accessToken: String
    
    var body: some View {
        TabView {
            FunctionsView()
            .padding()
            .tabItem {
                Label("Functions", systemImage: "music.quarternote.3")
            }
            ProfileView()
            .padding()
            .tabItem {
                Label("Profile", systemImage: "person.circle")
            }
        }
    }
}

#Preview {
    ContentView(accessToken: "Poopy")
}
