//
//  HTTPClient.swift
//  Clara Mobile Challenge
//
//  Created by Marcio Duarte on 2024-11-30.
//

import Foundation

protocol HTTPClient {
    typealias HTTPClientResult = (Data, HTTPURLResponse)
    
    func request(_ request: URLRequest) async throws -> HTTPClientResult
}
