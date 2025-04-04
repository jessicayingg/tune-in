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
                
                
                NavigationLink(destination: TrendsView()) {
                    FunctionButton(title: "Listening Trends", background: .red)
                }
                
                NavigationLink(destination: MoodAnalysisView()) {
                    FunctionButton(title: "Listening Moods", background: .pink)
                }
                
                NavigationLink(destination: TrendsView()) {
                    FunctionButton(title: "Discover New Music", background: .orange)
                }
                
                NavigationLink(destination: TrendsView()) {
                    FunctionButton(title: "Playlist Clean-up", background: .mint)
                }
                
                NavigationLink(destination: TrendsView()) {
                    FunctionButton(title: "Study Timer", background: .teal)
                }
                
                NavigationLink(destination: TrendsView()) {
                    FunctionButton(title: "Guess the Song!", background: .indigo)
                }
            }
        }
    }
}

#Preview {
    FunctionsView()
}
