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
    
    @Environment(\.isSearching)
    var isSearching
    
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
                LoadingView(message: Localizables.searching)
            } else if let errorMessage = viewModel.errorMessage {
                ErrorView(message: Localizables.errorOccurred(errorMessage))
            } else if viewModel.results.isEmpty && viewModel.query.isEmpty {
                EmptyStateView(message: Localizables.startTypingToSearch)
            } else if viewModel.results.isEmpty {
                EmptyStateView(message: Localizables.noResultsFound)
            } else {
                ArtistSearchResultsListView(
                    results: viewModel.results,
                    isLoading: viewModel.isLoading,
                    loadNextPage: viewModel.loadNextPage,
                    selection: $selection
                )
            }
        }
        .onChange(of: selection) { _ in
            dismissKeyboard()
        }
        .onChange(of: viewModel.query) { newQuery in
            if newQuery.isEmpty {
                selection = nil
            }
        }
        .onAppear {
            viewModel.discogsLoader = remoteLoader
        }
        .onChange(of: isSearching) { isSearching in
            if !isSearching {
                selection = nil
            }
        }
        .navigationTitle(Localizables.search)
        .searchable(text: $viewModel.query)
    }
}

#Preview {
    NavigationView {
        SearchScreenView()
    }
}
