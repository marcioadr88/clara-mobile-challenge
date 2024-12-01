//
//  ContentView.swift
//  Clara Mobile Challenge
//
//  Created by Marcio Duarte on 2024-11-30.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.horizontalSizeClass)
    var horizontalSizeClass
    
    var body: some View {
        if horizontalSizeClass == .compact {
            NavigationView {
                SearchScreenView()
            }
        } else {
            NavigationView {
                SearchScreenView()
                SearchResultsScreenView()
            }
        }
    }
}

#Preview {
    ContentView()
}
