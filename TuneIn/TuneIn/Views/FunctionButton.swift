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
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(background)
            
            HStack {
                Image(systemName: "music.note")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color.blue)
                    .frame(maxHeight: .infinity)
                    .padding()
                
                Text(title)
                    .foregroundColor(Color.white)
                    .bold()
                    .font(.system(size: 30))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        
        }
    }
}

#Preview {
    FunctionButton(title: "Value", background: .pink)
}
