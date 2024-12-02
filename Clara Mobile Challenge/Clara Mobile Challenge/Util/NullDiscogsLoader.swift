//
//  NullDiscogsLoader.swift
//  Clara Mobile Challenge
//
//  Created by Marcio Duarte on 2024-12-01.
//

import Foundation

struct NullDiscogsLoader: DiscogsLoader {
    enum Error: Swift.Error {
        case nullError
    }
    
    func search<Query>(query: String, type: Query, page: Int, perPage: Int) async throws -> Query.ReturnType where Query: SearchQueryType {
        throw Error.nullError
    }
    
    func getArtistDetails(artistID: Int) async throws -> ArtistDetail {
        throw Error.nullError
    }
    
    func getArtistRelease(artistID: Int, sortOrder: LoaderSortOrder, page: Int, perPage: Int) async throws -> ReleasesPaginatedResponse<ArtistRelease> {
        throw Error.nullError
    }
}
