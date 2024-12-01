//
//  ArtistSearchType.swift
//  Clara Mobile Challenge
//
//  Created by Marcio Duarte on 2024-11-30.
//

import Foundation

struct ArtistSearchType: SearchQueryType {
    typealias ReturnType = PaginatedResponse<ArtistSearchResult>
    
    var typeIdentifier: String {
        return "artist"
    }
}
