//
//  FunctionsView.swift
//  TuneIn
//
//  Created by Jessica Ying on 2025-04-01.
//

import SwiftUI

struct FunctionsView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome to Tune-in!")
                    .padding()
                    .bold()
                    .font(.title)
                
                
                // NavigationLink to TrendsView
                // Wrap the FunctionButton inside a NavigationLink
                NavigationLink(destination: TrendsView()) {
                    FunctionButton(title: "Listening Trends", background: .red) {
                        // other action here
                        // this doesn't work, figure something out
                    }
                }
                
                FunctionButton(title: "Listening Moods", background: .pink) {
                    // code for action
                }
                
                FunctionButton(title: "Discover New Music", background: .orange) {
                    // code for action
                }
                
                FunctionButton(title: "Playlist Clean-up", background: .mint) {
                    // code for action
                }
                
                FunctionButton(title: "Study Timer", background: .teal) {
                    // code for action
                }
                
                FunctionButton(title: "Guess the Song!", background: .indigo) {
                    // code for action
                }
            }
        }
    }
}

#Preview {
    FunctionsView()
}
