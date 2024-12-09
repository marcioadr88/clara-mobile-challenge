//
//  SearchResultsScreenView.swift
//  Clara Mobile Challenge
//
//  Created by Marcio Duarte on 2024-12-01.
//

import SwiftUI

struct SearchResultsScreenView: View {
    @Binding var selection: ArtistSearchResult?
    @StateObject private var viewModel = SearchResultsScreenViewModel()
    
    @Environment(\.remoteDiscogsLoader)
    var discogsLoader
    
    init(selection: Binding<ArtistSearchResult?>) {
        _selection = selection
    }
    
    init() {
        _selection = Binding(get: { nil }, set: { _ in })
    }
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                LoadingView(message: Localizables.loadingArtistDetails)
            } else if let errorMessage = viewModel.errorMessage {
                ErrorView(message: Localizables.errorOccurred(errorMessage))
            } else if let detail = viewModel.artistDetail {
                ScrollView(.vertical) {
                    ArtistDetailsContentView(artistDetail: detail)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .padding()
                }
            } else {
                EmptyStateView(message: Localizables.selectArtist)
            }
        }
        .onChange(of: selection) { _ in
            loadArtistDetails()
        }
        .onAppear {
            viewModel.loader = discogsLoader
            
            if !viewModel.isLoaded {
                loadArtistDetails()
            }
        }
        .navigationTitle(selection?.title ?? "")
    }
    
    func loadArtistDetails() {
        if let artistID = selection?.id {
            viewModel.loadArtistDetails(artistID: artistID)
        } else {
            viewModel.artistDetail = nil
        }
    }
}

#Preview {
    SearchResultsScreenView()
}
