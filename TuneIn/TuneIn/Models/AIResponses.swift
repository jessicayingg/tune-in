//
//  AIResponses.swift
//  TuneIn
//
//  Created by Jessica Ying on 2025-04-06.
//
// This file is to allow for json decoding of the ai's json-formatted response

import Foundation

struct AIResponseTrack: Codable {
    let title: String
    let artistName: String
}
