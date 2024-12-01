//
//  Pagination.swift
//  Clara Mobile Challenge
//
//  Created by Marcio Duarte on 2024-11-30.
//

import Foundation

struct PaginatedResponse<T: Decodable>: Decodable {
    let pagination: Pagination
    let results: [T]
}

struct Pagination: Decodable {
    let page: Int
    let pages: Int
    let perPage: Int
    let items: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case pages
        case perPage = "per_page"
        case items
    }
}
