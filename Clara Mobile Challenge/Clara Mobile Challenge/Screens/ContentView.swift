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
    
    @State private var selectedArtist: ArtistSearchResult?
    
    var body: some View {
        if horizontalSizeClass == .compact {
            NavigationView {
                SearchScreenView(selection: $selectedArtist)
            }
        } else {
            NavigationView {
                SearchScreenView(selection: $selectedArtist)
                SearchResultsScreenView(selection: $selectedArtist)
            }
        }
    }
}

#Preview {
    ContentView()
}
