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
    let urls: PaginationUrls?
}

struct PaginationUrls: Decodable {
    let last: String?
    let next: String?
}
