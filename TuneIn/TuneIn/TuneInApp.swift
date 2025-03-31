//
//  TuneInApp.swift
//  TuneIn
//
//  Created by Jessica Ying on 2025-03-30.
//

import SwiftUI

@main
struct TuneInApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            LoginView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if url.scheme == "tunein" {
            print("Redirected with URL: \(url)")
            // Extract 'code' from URL and exchange for access token
        }
        return true
    }
}
