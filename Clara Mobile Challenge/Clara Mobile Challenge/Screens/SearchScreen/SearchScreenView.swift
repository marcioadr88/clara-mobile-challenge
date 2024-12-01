//
//  SearchScreenView.swift
//  Clara Mobile Challenge
//
//  Created by Marcio Duarte on 2024-12-01.
//

import SwiftUI

struct SearchScreenView: View {
    @StateObject private var viewModel = SearchViewModel()
    @State var selection: ArtistSearchResult?
    
    @Environment(\.remoteDiscogsLoader)
    var remoteLoader
    
    init() {}
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Searching...")
                    .padding()
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            } else if viewModel.results.isEmpty {
                Text("Start typing to search for artists")
                    .foregroundColor(.gray)
                    .padding()
            } else {
                List(selection: $selection) {
                    ForEach(viewModel.results, id: \.id) { artist in
                        ArtistSearchResultView(artist: artist)
                    }
                }
            }
        }
        .onAppear {
            viewModel.discogsLoader = remoteLoader
        }
        .navigationTitle("Search")
        .searchable(text: $viewModel.query)
    }
}

#Preview {
    NavigationView {
        SearchScreenView()
    }
}
