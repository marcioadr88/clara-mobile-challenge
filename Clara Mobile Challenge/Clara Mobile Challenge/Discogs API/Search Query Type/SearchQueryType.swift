//
//  SearchQueryType.swift
//  Clara Mobile Challenge
//
//  Created by Marcio Duarte on 2024-11-30.
//

import Foundation

protocol SearchQueryType {
    associatedtype ReturnType: Decodable
    
    // Identifier to be sent to the query
    var typeIdentifier: String { get }
}
