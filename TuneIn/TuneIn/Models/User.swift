//
//  User.swift
//  TuneIn
//
//  Created by Jessica Ying on 2025-04-01.
//

import Foundation

struct User: Codable {
    // This is what a user is going to look like:
    // All about authentication and session management
    let accessToken: String?
    let refreshToken: String?
    let tokenExpirationDate: TimeInterval?
    // General user things
    let id: String?
    let name: String
    let email: String
    let profileURL: String?
    let country: String?
    let subscription: String? // premium or free
    
}
