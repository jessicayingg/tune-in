//
//  FunctionsView.swift
//  TuneIn
//
//  Created by Jessica Ying on 2025-04-01.
//

import SwiftUI

struct FunctionsView: View {
    var body: some View {
        VStack {
            Text("Welcome to Tune-in!")
                .padding()
                .bold()
                .font(.title)
            FunctionButton(title: "Listening Trends", background: .red) {
                // code for action
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

#Preview {
    FunctionsView()
}
