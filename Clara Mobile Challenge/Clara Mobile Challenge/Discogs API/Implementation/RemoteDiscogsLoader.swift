//
//  RemoteDiscogsLoader.swift
//  Clara Mobile Challenge
//
//  Created by Marcio Duarte on 2024-11-30.
//

import Foundation

class RemoteDiscogsLoader: DiscogsLoader {
    private let baseURL: URL
    private let apiKey: String
    private let apiSecret: String
    private let httpClient: HTTPClient

    init(
        baseURL: URL,
        apiKey: String,
        apiSecret: String,
        httpClient: HTTPClient
    ) {
        self.baseURL = baseURL
        self.apiKey = apiKey
        self.apiSecret = apiSecret
        self.httpClient = httpClient
    }

    func search<Query: SearchQueryType>(
        query: String,
        type: Query,
        page: Int
    ) async throws -> Query.ReturnType {
        let searchURL = baseURL.appendingPathComponent("/database/search")
        
        guard var urlComponents = URLComponents(url: searchURL, resolvingAgainstBaseURL: true) else {
            throw RemoteDiscogsLoaderError.badRequest
        }

        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "type", value: type.typeIdentifier),
            URLQueryItem(name: "page", value: String(page))
        ]

        guard let url = urlComponents.url else {
            throw RemoteDiscogsLoaderError.badRequest
        }

        // Prepare the request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(
            "Discogs key=\(apiKey), secret=\(apiSecret)",
            forHTTPHeaderField: "Authorization"
        )

        var (data, httpResponse): (Data, HTTPURLResponse)

        do {
            (data, httpResponse) = try await httpClient.request(request)
        } catch {
            throw RemoteDiscogsLoaderError.httpClientError(reason: error)
        }

        // Handle non-200 HTTP responses
        guard httpResponse.statusCode == 200 else {
            if httpResponse.statusCode == 500 {
                if let serverError = try? JSONDecoder().decode(RemoteError.self, from: data) {
                    throw RemoteDiscogsLoaderError.serverError(message: serverError.message)
                }
            }
            throw RemoteDiscogsLoaderError.serverError(message: nil)
        }

        // Decode the responsea
        do {
            return try JSONDecoder().decode(Query.ReturnType.self, from: data)
        } catch {
            throw RemoteDiscogsLoaderError.invalidData
        }
    }
}
