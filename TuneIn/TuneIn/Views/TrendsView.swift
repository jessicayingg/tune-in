//
//  TrendsView.swift
//  TuneIn
//
//  Created by Jessica Ying on 2025-04-01.
//

import SwiftUI

struct TrendsView: View {
    let user: User
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
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

    return TrendsView(user: dummyUser)
}
