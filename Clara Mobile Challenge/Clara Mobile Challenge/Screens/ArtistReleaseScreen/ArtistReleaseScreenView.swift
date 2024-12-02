//
//  ArtistReleaseScreenView.swift
//  Clara Mobile Challenge
//
//  Created by Marcio Duarte on 2024-12-02.
//

import SwiftUI

import SwiftUI

struct ArtistReleaseScreenView: View {
    private let artist: ArtistDetail
    @StateObject private var viewModel = ArtistReleaseViewModel()
    
    @Environment(\.remoteDiscogsLoader)
    var discogsLoader
    
    init(artist: ArtistDetail) {
        self.artist = artist
    }
    
    var body: some View {
        VStack {
            if viewModel.isLoading && viewModel.releases.isEmpty {
                LoadingView(message: Localizables.loadingReleases)
            } else if let errorMessage = viewModel.errorMessage {
                ErrorView(message: Localizables.errorOccurred(errorMessage))
            } else {
                List(viewModel.releases) { release in
                    ArtistReleaseRowView(release: release)
                        .onAppear {
                            if release == viewModel.releases.last {
                                viewModel.loadNextPage()
                            }
                        }
                    
                    if release == viewModel.releases.last && viewModel.isLoading {
                        ProgressView(Localizables.loadingMore)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle(Localizables.artistReleases(artist.name))
        .onAppear {
            viewModel.loader = discogsLoader
            viewModel.loadReleases(for: artist.id)
        }
    }
}
