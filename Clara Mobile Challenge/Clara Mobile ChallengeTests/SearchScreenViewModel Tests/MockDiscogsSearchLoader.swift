//
//  MockDiscogsSearchLoader.swift
//  Clara Mobile ChallengeTests
//
//  Created by Marcio Duarte on 2024-12-01.
//

import Foundation
@testable import Clara_Mobile_Challenge

final class MockDiscogsSearchLoader: DiscogsSearchLoader {
    struct MockSearchResult: SearchQueryType {
        typealias ReturnType = SearchPaginatedResponse<ArtistSearchResult>
        var typeIdentifier: String = "mock"
    }
    
    var results: [ArtistSearchResult] = []
    var totalPages: Int = 1
    var items: Int = 30
    var error: Error?
    
    func search<Query: SearchQueryType>(
        query: String,
        type: Query,
        page: Int,
        perPage: Int
    ) async throws -> Query.ReturnType {
        if let error = error {
            throw error
        }
        
        return SearchPaginatedResponse(
            pagination: Pagination(page: page, pages: totalPages, perPage: perPage, items: items),
            results: results
        ) as! Query.ReturnType
    }
}
