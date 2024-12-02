//
//  SearchResultsScreenViewModel.swift
//  Clara Mobile Challenge
//
//  Created by Marcio Duarte on 2024-12-01.
//

import Foundation

class SearchResultsScreenViewModel: ObservableObject {
    @Published var artistDetail: ArtistDetail?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    var isLoaded: Bool = false
    
    var loader: DiscogsGetArtistsDetailsLoader?
    
    func loadArtistDetails(artistID: Int) {
        guard let loader else {
            errorMessage = "No loader available"
            return
        }
        
        Task {
            await load(artistID: artistID, with: loader)
        }
    }
    
    @MainActor
    func load(artistID: Int, with loader: DiscogsGetArtistsDetailsLoader) async {
        do {
            isLoading = true
            isLoaded = false
            artistDetail = try await Task(priority: .background) {
                try await loader.getArtistDetails(artistID: artistID)
            }.value
            
            isLoaded = true
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
}
