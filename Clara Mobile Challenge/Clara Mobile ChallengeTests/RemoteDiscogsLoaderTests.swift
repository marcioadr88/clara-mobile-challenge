//
//  RemoteDiscogsLoaderTests.swift
//  Clara Mobile ChallengeTests
//
//  Created by Marcio Duarte on 2024-11-30.
//

import XCTest
@testable import Clara_Mobile_Challenge

class RemoteDiscogsLoaderTests: XCTestCase {
    func makeSUT(httpClient: HTTPClient = HTTPClientSpy()) -> DiscogsLoader {
        return RemoteDiscogsLoader(
            baseURL: anyBaseURL(),
            apiKey: anyApiKey(),
            apiSecret: anyApiSecret(),
            httpClient: httpClient
        )
    }
    
    func makeJSONFromDictionary(_ dictionary: [String: Any]) throws -> Data {
        return try JSONSerialization.data(withJSONObject: dictionary, options: [])
    }
    
    func anyBaseURL() -> URL {
        return URL(string: "http://example.com")!
    }
    
    func anyApiKey() -> String {
        return ""
    }
    
    func anyApiSecret() -> String {
        return ""
    }
}
