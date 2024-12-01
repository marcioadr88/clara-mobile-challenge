//
//  ArtistSearchResultsListView.swift
//  Clara Mobile Challenge
//
//  Created by Marcio Duarte on 2024-12-01.
//

import SwiftUI

struct ArtistSearchResultsListView: View {
    let results: [ArtistSearchResult]
    let isLoading: Bool
    let loadNextPage: () -> Void
    
    @Binding var selection: ArtistSearchResult?
    
    var body: some View {
        List(results, id: \.self, selection: $selection) { artist in
            NavigationLink {
                SearchResultsScreenView(selection: $selection)
            } label: {
                VStack(alignment: .leading) {
                    ArtistSearchResultView(artist: artist)
                        .onAppear {
                            if artist == results.last {
                                loadNextPage()
                            }
                        }
                }
            }
            
            if artist == results.last && isLoading {
                ProgressView("Loading more...")
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
    }
}
