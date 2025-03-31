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
            VStack {
                Text("Welcome to Tune In")
                    .font(.largeTitle)
                    .padding()

                Text("Your Access Token:")
                Text(accessToken)
                    .font(.caption)
                    .padding()
                    .foregroundColor(.gray)

                Button("Logout") {
                    // Go back to LoginView
                }
                .foregroundColor(.red)
            }
            .padding()
        }
    }
}

#Preview {
    ContentView(accessToken: "Poopy")
}
