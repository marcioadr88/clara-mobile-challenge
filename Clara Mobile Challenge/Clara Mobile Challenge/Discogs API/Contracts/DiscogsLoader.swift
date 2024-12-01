//
//  DiscogsAPI.swift
//  Clara Mobile Challenge
//
//  Created by Marcio Duarte on 2024-11-30.
//

import Foundation

protocol DiscogsLoader {
    func search<Query: SearchQueryType>(
        query: String,
        type: Query,
        page: Int
    ) async throws -> Query.ReturnType
    
    func getArtistDetails(artistID: Int) async throws -> ArtistDetail
}
