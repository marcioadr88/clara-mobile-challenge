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
                List(viewModel.results, id: \.self, selection: $selection) { artist in
                    NavigationLink {
                        SearchResultsScreenView(selection: $selection)
                    } label: {
                        VStack(alignment: .leading) {
                            ArtistSearchResultView(artist: artist)
                                .onAppear {
                                    if artist == viewModel.results.last {
                                        viewModel.loadNextPage()
                                    }
                                }
                            
                        }
                    }
                    
                    if artist == viewModel.results.last && viewModel.isLoading {
                        ProgressView("Loading more...")
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
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
