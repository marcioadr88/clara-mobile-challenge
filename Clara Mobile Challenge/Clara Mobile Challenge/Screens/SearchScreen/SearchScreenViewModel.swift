//
//  SearchScreenViewModel.swift
//  Clara Mobile Challenge
//
//  Created by Marcio Duarte on 2024-12-01.
//

import SwiftUI
import Combine
import Foundation

class SearchViewModel: ObservableObject {
    @Published var query: String = ""
    @Published var results: [ArtistSearchResult] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    var discogsLoader: DiscogsLoader?
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        bindQuery()
    }
    
    private func bindQuery() {
        $query
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] query in
                guard !query.isEmpty else {
                    self?.results = []
                    return
                }
                
                self?.performSearch(query: query)
            }
            .store(in: &cancellables)
    }
    
    private func performSearch(query: String) {
        Task { @MainActor in
            isLoading = true
            await performArtistSearchWithLoader(query: query, loader: discogsLoader)
            isLoading = false
        }
    }
    
    @MainActor
    private func performArtistSearchWithLoader(query: String, loader: DiscogsLoader?) async {
        do {
            let pageContent = try await Task(priority: .background) {
                return try await loader?.search(query: query, type: ArtistSearchType(), page: 1)
            }.value
            
            results.append(contentsOf: pageContent?.results ?? [])
        } catch let error {
            errorMessage = error.localizedDescription
        }
    }
}
