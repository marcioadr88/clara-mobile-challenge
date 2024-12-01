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
    
    var discogsLoader: DiscogsSearchLoader?
    private var cancellables = Set<AnyCancellable>()
    
    private var currentPage: Int = 1
    private var totalPages: Int = 1
    
    init() {
        bindQuery()
    }
    
    private func bindQuery() {
        $query
            .debounce(for: .milliseconds(400), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] query in
                guard !query.isEmpty else {
                    self?.reset()
                    return
                }
                
                self?.performNewSearch(query: query)
            }
            .store(in: &cancellables)
    }
    
    private func reset() {
        currentPage = 1
        totalPages = 1
        results = []
    }
    
    private func performNewSearch(query: String) {
        reset()
        search()
    }
    
    func loadNextPage() {
        guard currentPage <= totalPages else { return }
        
        search()
    }
    
    private func search() {
        Task { @MainActor in
            isLoading = true
            await performArtistSearchWithLoader(query: query, loader: discogsLoader)
            isLoading = false
        }
    }
    
    @MainActor
    private func performArtistSearchWithLoader(query: String, loader: DiscogsSearchLoader?) async {
        do {
            let pageContent = try await Task(priority: .background) {
                try await loader?.search(
                    query: query,
                    type: ArtistSearchType(),
                    page: currentPage,
                    perPage: 30
                )
            }.value
            
            guard let pageContent else { return }
            
            totalPages = pageContent.pagination.pages
            currentPage += 1
            
            results.append(contentsOf: pageContent.results)
        } catch let error {
            errorMessage = error.localizedDescription
        }
    }
}
