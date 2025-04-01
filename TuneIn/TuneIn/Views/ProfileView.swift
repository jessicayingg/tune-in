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
            Image(systemName: "person.circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(Color.blue)
                .frame(width: 125, height: 125)
                .padding()
            
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
            
            VStack {
                Text("Listening Trends: ")
                
                VStack {
                    Text("Listening Duration")
                    // Graph here
                }
                
                VStack {
                    Text("Genres Listened To")
                    // Graph here
                }
            }
            .padding()
            
        }
        .padding()
    }
}
/*
#Preview {
    ProfileView()
}
*/
