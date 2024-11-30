//
//  URLSessionHTTPClient.swift
//  Clara Mobile Challenge
//
//  Created by Marcio Duarte on 2024-11-30.
//

import Foundation

class URLSessionHTTPClient: HTTPClient {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request(_ request: URLRequest) async throws -> HTTPClientResult {
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw URLError(.badServerResponse)
            }
            
            return (data, httpResponse)
        } catch {
            throw error
        }
    }
}
