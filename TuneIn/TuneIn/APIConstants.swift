//
//  APIConstants.swift
//  TuneIn
//
//  Created by Jessica Ying on 2025-03-30.
//

import Foundation

enum APIConstants {
    static let apiHost = "api.spotify.com"
    static let authHost = "accounts.spotify.com"
    static let clientId = "09972d8a63b341e0b2e207d495603ae6"
    static let clientSecret = "2b87eb3064514a638e763fd2c32b2159"
    static let redirectUri = "tunein://callback"
    static let responseType = "token"
    
    // things we want to get from the user
    static let scopes = "user-read-private user-read-email user-top-read user-read-recently-played"
    
    static var authParams = [
        "response_type": responseType,
        "client_id": clientId,
        "redirect_uri": redirectUri,
        "scope": scopes
    ]
    
    // OpenAI key
    static let openAIKey: String = {
        guard let key = Bundle.main.infoDictionary?["OPENAI_API_KEY"] as? String else {
            fatalError("OPENAI_API_KEY not found in Info.plist")
        }
        return key
    }()
    
    static let openRouterKey = Bundle.main.infoDictionary?["OPENROUTER_API_KEY"] as? String ?? ""
}
