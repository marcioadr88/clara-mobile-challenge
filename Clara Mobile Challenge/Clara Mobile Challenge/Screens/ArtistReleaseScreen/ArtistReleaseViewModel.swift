//
//  ArtistReleaseViewModel.swift
//  Clara Mobile Challenge
//
//  Created by Marcio Duarte on 2024-12-02.
//

import SwiftUI

@MainActor
class ArtistReleaseViewModel: ObservableObject {
    @Published var releases: [ArtistRelease] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    var loader: DiscogsGetArtistReleasesLoader?
    private var currentPage: Int = 1
    private var totalPages: Int = 1
    private var artistID: Int?
    
    func loadReleases(for artistID: Int) {
        self.artistID = artistID
        resetState()
        loadPage()
    }
    
    func loadNextPage() {
        guard currentPage <= totalPages else { return }
        loadPage()
    }
    
    private func loadPage() {
        guard let loader = loader, let artistID = artistID, !isLoading else { return }
        
        isLoading = true
        Task {
            do {
                let response = try await loader.getArtistRelease(
                    artistID: artistID,
                    sortOrder: .desc,
                    page: currentPage,
                    perPage: 30
                )
                releases.append(contentsOf: response.releases)
                totalPages = response.pagination.pages
                currentPage += 1
                isLoading = false
            } catch {
                errorMessage = error.localizedDescription
                isLoading = false
            }
        }
    }
    
    private func resetState() {
        releases = []
        errorMessage = nil
        isLoading = false
        currentPage = 1
        totalPages = 1
    }
}
