//
//  ArtistReleaseScreenView.swift
//  Clara Mobile Challenge
//
//  Created by Marcio Duarte on 2024-12-02.
//

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
                List(viewModel.filteredReleases) { release in
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
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu("\(Localizables.year): \(selectedYearText())") {
                    Picker(Localizables.year, selection: $viewModel.currentYearFilter) {
                        Text(Localizables.allYears).tag(nil as Int?)
                        
                        ForEach(viewModel.availableYears, id: \.self) { year in
                            Text(String(format: "%d", year)).tag(year as Int?)
                        }
                    }
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu("\(Localizables.label): \(selectedLabelText())") {
                    Picker(Localizables.label, selection: $viewModel.currentLabelFilter) {
                        Text(Localizables.allLabels).tag(nil as String?)
                        ForEach(viewModel.availableLabels, id: \.self) { label in
                            Text(label).tag(label as String?)
                        }
                    }
                }
            }
        }
        .onChange(of: viewModel.currentYearFilter) { _ in
            viewModel.applyFilters()
        }
        .onChange(of: viewModel.currentLabelFilter) { _ in
            viewModel.applyFilters()
        }
    }
    
    private func selectedYearText() -> String {
        if let year = viewModel.currentYearFilter {
            return String(format: "%d", year)
        } else {
            return Localizables.all
        }
    }
    
    private func selectedLabelText() -> String {
        viewModel.currentLabelFilter ?? Localizables.all
    }
}
