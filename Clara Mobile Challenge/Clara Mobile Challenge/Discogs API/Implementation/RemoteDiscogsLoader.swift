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
    
    // MARK: - Helper Methods
    
    private func createRequest(for path: String, queryItems: [URLQueryItem] = []) throws -> URLRequest {
        let fullURL = baseURL.appendingPathComponent(path)
        guard var urlComponents = URLComponents(url: fullURL, resolvingAgainstBaseURL: true) else {
            throw RemoteDiscogsLoaderError.badRequest
        }
        
        urlComponents.queryItems = queryItems.isEmpty ? nil : queryItems
        
        guard let url = urlComponents.url else {
            throw RemoteDiscogsLoaderError.badRequest
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(
            "Discogs key=\(apiKey), secret=\(apiSecret)",
            forHTTPHeaderField: "Authorization"
        )
        
        return request
    }
    
    private func performRequest<T: Decodable>(_ request: URLRequest) async throws -> T {
        var (data, httpResponse): (Data, HTTPURLResponse)
        
        do {
            (data, httpResponse) = try await httpClient.request(request)
        } catch {
            throw RemoteDiscogsLoaderError.httpClientError(reason: error)
        }
        
        guard httpResponse.statusCode == 200 else {
            if let serverError = try? JSONDecoder().decode(RemoteError.self, from: data) {
                throw RemoteDiscogsLoaderError.serverError(message: serverError.message)
            } else {
                throw RemoteDiscogsLoaderError.serverError(message: nil)
            }
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw RemoteDiscogsLoaderError.invalidData
        }
    }
}

extension RemoteDiscogsLoader: DiscogsSearchLoader {
    func search<Query: SearchQueryType>(
        query: String,
        type: Query,
        page: Int = 1,
        perPage: Int = 30
    ) async throws -> Query.ReturnType {
        let queryItems = [
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "type", value: type.typeIdentifier),
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "per_page", value: String(perPage))
        ]
        
        let request = try createRequest(for: "/database/search", queryItems: queryItems)
        return try await performRequest(request)
    }
}

extension RemoteDiscogsLoader: DiscogsGetArtistsDetailsLoader {
    func getArtistDetails(artistID: Int) async throws -> ArtistDetail {
        let request = try createRequest(for: "/artists/\(artistID)")
        return try await performRequest(request)
    }
}

extension RemoteDiscogsLoader: DiscogsGetArtistReleasesLoader {
    func getArtistRelease(artistID: Int, sortOrder: LoaderSortOrder, page: Int, perPage: Int) async throws -> PaginatedResponse<ArtistRelease> {
        let queryItems = [
            URLQueryItem(name: "sort_order", value: sortOrder.rawValue),
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "per_page", value: String(perPage))
        ]
        
        let request = try createRequest(for: "/artists/\(artistID)/releases", queryItems: queryItems)
        return try await performRequest(request)
    }
}
