//
//  SearchScreenView.swift
//  Clara Mobile Challenge
//
//  Created by Marcio Duarte on 2024-12-01.
//

import SwiftUI

struct SearchScreenView: View {
    @StateObject private var viewModel = SearchViewModel()
    @Binding var selection: ArtistSearchResult?
    
    @Environment(\.remoteDiscogsLoader)
    var remoteLoader
    
    init(selection: Binding<ArtistSearchResult?>) {
        _selection = selection
    }
    
    init() {
        _selection = .constant(nil)
    }
    
    var body: some View {
        VStack {
            if viewModel.isLoading && viewModel.results.isEmpty {
                LoadingView(message: "Searching...")
            } else if let errorMessage = viewModel.errorMessage {
                ErrorView(message: errorMessage)
            } else if viewModel.results.isEmpty {
                EmptyStateView(message: "Start typing to search for artists")
            } else {
                ArtistSearchResultsListView(
                    results: viewModel.results,
                    isLoading: viewModel.isLoading,
                    loadNextPage: viewModel.loadNextPage, 
                    selection: $selection
                )
            }
        }
        .onChange(of: viewModel.query) { newQuery in
            if newQuery.isEmpty {
                selection = nil
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
