//
//  APIService.swift
//  TuneIn
//
//  Created by Jessica Ying on 2025-03-30.
//

import Foundation

class APIService {
    static let shared = APIService()
    
    func getAccessTokenURL() -> URLRequest? {
        var components = URLComponents()
        components.scheme = "https"
        // Working on authorization here for log in, so use authHost constant
        components.host = APIConstants.authHost
        // Part of the url when you're logging in
        components.path = "/authorize"
        
        // The dictionary authParams has keys and values, we want to convert them
        // into an array of URLQueryItem objects
        components.queryItems = APIConstants.authParams.map(
            { (key, value) in
                    URLQueryItem(name: key, value: value)
                })
        
        guard let url = components.url else {
            return nil
        }
        
        return URLRequest(url: url)
    }
}
