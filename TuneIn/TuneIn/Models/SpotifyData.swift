//
//  SpotifyData.swift
//  TuneIn
//
//  Created by Jessica Ying on 2025-04-04.
//

import Foundation

// An individual song
struct Track: Codable {
    let id: String
    let name: String
    let artists: [Artist]
    let album: Album
}

// An artist
struct Artist: Codable {
    let name: String
}

// An album
struct Album: Codable {
    let name: String
    let images: [AlbumImage]
}

// An image
struct AlbumImage: Codable {
    let url: String
}

// For the top tracks api call response
struct TopTracksResponse: Codable {
    let items: [Track]
}
