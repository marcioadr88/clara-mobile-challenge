//
//  ClaraMobileChallengeApp.swift
//  Clara Mobile Challenge
//
//  Created by Marcio Duarte on 2024-11-30.
//

import SwiftUI

@main
struct ClaraMobileChallengeApp: App {
    private let remoteLoader: DiscogsLoader
    
    init() {
        guard let baseURL = URL(string: "https://api.discogs.com") else {
            fatalError("Failed to create base URL")
        }
        
        let httpClient: HTTPClient = URLSessionHTTPClient()
        
        remoteLoader = RemoteDiscogsLoader(
            baseURL: baseURL,
            apiKey: "VFbYUhMzePeoOiCOWXQq",
            apiSecret: "ZWXwFHNSicMydilUwQeiqDPyKQZuKsnC",
            httpClient: httpClient
        )
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(
                    \.userInterfaceIdiom,
                     UserInterfaceIdiom.from(UIDevice.current.userInterfaceIdiom)
                )
                .environment(\.remoteDiscogsLoader, remoteLoader)
        }
    }
}
