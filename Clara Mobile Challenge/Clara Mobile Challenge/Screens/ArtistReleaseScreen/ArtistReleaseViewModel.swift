//
//  ArtistReleaseViewModel.swift
//  Clara Mobile Challenge
//
//  Created by Marcio Duarte on 2024-12-02.
//

import Foundation
import SwiftUI

@MainActor
class ArtistReleaseViewModel: ObservableObject {
    @Published var releases: [ArtistRelease] = []
    @Published var filteredReleases: [ArtistRelease] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    var loader: DiscogsGetArtistReleasesLoader?
    private var currentPage: Int = 1
    private var totalPages: Int = 1
    private var artistID: Int?
    
    @Published var currentYearFilter: Int?
    @Published var currentLabelFilter: String?
    
    var availableYears: [Int] {
        Array(Set(releases.compactMap { $0.year })).sorted(by: >)
    }
    
    var availableLabels: [String] {
        Array(Set(releases.compactMap { $0.label })).sorted()
    }
    
    func loadReleases(for artistID: Int) {
        self.artistID = artistID
        resetState()
        loadPage()
    }
    
    func loadNextPage() {
        guard currentPage <= totalPages else { return }
        loadPage()
    }
    
    func applyFilters() {
        filteredReleases = releases.filter { release in
            var matches = true
            
            if let year = currentYearFilter {
                matches = matches && release.year == year
            }
            
            if let label = currentLabelFilter {
                matches = matches && release.label == label
            }
            
            return matches
        }
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
                
                // Agregar lanzamientos a la lista principal
                releases.append(contentsOf: response.releases)
                
                // Volver a aplicar los filtros actuales
                applyFilters()
                
                // Actualizar el estado de paginación
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
        filteredReleases = []
        errorMessage = nil
        isLoading = false
        currentPage = 1
        totalPages = 1
        currentYearFilter = nil
        currentLabelFilter = nil
    }
}
