//
//  NetworkError.swift
//  TuneIn
//
//  Created by Jessica Ying on 2025-03-30.
//

// This file handles network errors

import Foundation

// Conforms to Swift's Error protocol
// Declaring errors that can be thrown later on
enum NetworkError: Error {
    case invalidURL
    case invalidServerResponse
    case generalError
    
    // Example usage: throw Networkerror.invalidURL
}
