//
//  ClaraMobileChallengeApp.swift
//  Clara Mobile Challenge
//
//  Created by Marcio Duarte on 2024-11-30.
//

import SwiftUI

@main
struct ClaraMobileChallengeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(
                    \.userInterfaceIdiom,
                     UserInterfaceIdiom.from(UIDevice.current.userInterfaceIdiom)
                )
        }
    }
}
