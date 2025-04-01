//
//  SpotifyUserResponse.swift
//  TuneIn
//
//  Created by Jessica Ying on 2025-04-01.
//

import Foundation

struct SpotifyUserResponse: Codable {
    // General user things
    let id: String
    let displayName: String
    let email: String
    let country: String?
    let product: String? // premium or free
    let images: [SpotifyImage] // array of images
}

struct SpotifyImage: Codable {
    let url: String
}
