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
    let background: Color
    let action: () -> Void
    
    var body: some View {
        Button {
            // Some kind of action
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(background)
                
                Text(title)
                    .foregroundColor(Color.white)
                    .bold()
            }
        }
    }
}

#Preview {
    FunctionButton(title: "Value",
                   background: .pink) {
        
    }
}
