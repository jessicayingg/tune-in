//
//  FunctionButton.swift
//  TuneIn
//
//  Created by Jessica Ying on 2025-04-01.
//

import SwiftUI

struct FunctionButton: View {
    // Things that will be passed in
    let title: String
    //let background: Color
    
    var body: some View {
        // Stack things on top of each other
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.clear)
                .shadow(radius: 10)
                .opacity(0.5)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(
                            LinearGradient(
                                gradient: Gradient(
                                    colors:
                                        [Color.indigo, Color.orange, Color.red]
                                ),
                                startPoint: .topLeading, // top left
                                endPoint: .bottomTrailing // bottom right
                            ),
                            lineWidth: 5 // border width
                        )
                )
            
            HStack {
                Text(title)
                    .bold()
                    .font(.headline)
                    .fontWeight(.semibold)
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        
        }
    }
}

#Preview {
    //FunctionButton(title: "Value", background: .pink)
    FunctionButton(title: "Value")
}
