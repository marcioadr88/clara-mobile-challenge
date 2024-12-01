//
//  DiscogsAPI.swift
//  Clara Mobile Challenge
//
//  Created by Marcio Duarte on 2024-11-30.
//

import Foundation

protocol DiscogsSearchLoader {
    func search<Query: SearchQueryType>(
        query: String,
        type: Query,
        page: Int,
        perPage: Int
    ) async throws -> Query.ReturnType
}

protocol DiscogsGetArtistsDetailsLoader {
    func getArtistDetails(artistID: Int) async throws -> ArtistDetail
}

protocol DiscogsLoader: DiscogsSearchLoader, DiscogsGetArtistsDetailsLoader {}
