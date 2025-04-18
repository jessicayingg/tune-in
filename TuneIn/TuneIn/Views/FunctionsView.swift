//
//  FunctionsView.swift
//  TuneIn
//
//  Created by Jessica Ying on 2025-04-01.
//

import SwiftUI

struct FunctionsView: View {
    let user: User
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome to Tune-in!")
                    .padding(.top, 50)
                    .bold()
                    .font(.title)
                
                NavigationLink(destination: NewMusicView(user: user)) {
                    //FunctionButton(title: "Discover New Music", background: .orange)
                    FunctionButton(title: "Discover New Music")
                }
                .buttonStyle(PlainButtonStyle())
                .padding()
                
                NavigationLink(destination: TrendsView(user: user)) {
                    //FunctionButton(title: "Listening Trends", background: .red)
                    FunctionButton(title: "Listening Trends")
                }
                .buttonStyle(PlainButtonStyle())
                .padding()
                
                NavigationLink(destination: MoodAnalysisView()) {
                    //FunctionButton(title: "Listening Moods", background: .pink)
                    FunctionButton(title: "Listening Moods")
                }
                .buttonStyle(PlainButtonStyle())
                .padding()
                
                NavigationLink(destination: MoodAnalysisView()) {
                    //FunctionButton(title: "Playlist Clean-up", background: .mint)
                    FunctionButton(title: "Playlist Clean-up")
                }
                .buttonStyle(PlainButtonStyle())
                .padding()
                
                NavigationLink(destination: MoodAnalysisView()) {
                    //FunctionButton(title: "Study Timer", background: .teal)
                    FunctionButton(title: "Study Timer")
                }
                .buttonStyle(PlainButtonStyle())
                .padding()
                
                NavigationLink(destination: MoodAnalysisView()) {
                    //FunctionButton(title: "Guess the Song!", background: .indigo)
                    FunctionButton(title: "Guess the Song")
                }
                .buttonStyle(PlainButtonStyle())
                .padding()
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

    return FunctionsView(user: dummyUser)
}
