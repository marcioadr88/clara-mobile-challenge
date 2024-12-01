//
//  RemoteDiscogsLoaderTests.swift
//  Clara Mobile ChallengeTests
//
//  Created by Marcio Duarte on 2024-11-30.
//

import XCTest
@testable import Clara_Mobile_Challenge

class RemoteDiscogsLoaderTests: XCTestCase {
    func test_requestCompletesWithSuccess() async throws {
        // Given
        let spy = HTTPClientSpy()
        let sut = makeSUT(httpClient: spy)
        let expectedDataReturn = DummyQuery.ReturnType(expectedResult: "success")
        let dummyData = expectedDataReturn.json.data(using: .utf8)!
        
        // when
        spy.completeNextRequest(withStatusCode: 200, data: dummyData)
        
        let result = try await sut.search(query: "query", type: DummyQuery(), page: 1)
        
        // then
        XCTAssertEqual(result, expectedDataReturn)
    }
    
    func test_requestCompletesWithError() async throws {
        let spy = HTTPClientSpy()
        let sut = makeSUT(httpClient: spy)
        let expectedError = NSError(domain: "TestError", code: 1, userInfo: nil)
        
        spy.completeNextRequest(with: expectedError)
        
        do {
            let _ = try await sut.search(query: "query", type: DummyQuery(), page: 1)
            
            XCTFail("Should throw error")
        } catch RemoteDiscogsLoaderError.httpClientError(let reason) {
            let nsError = reason as NSError
            XCTAssertEqual(nsError.domain, expectedError.domain)
            XCTAssertEqual(nsError.code, expectedError.code)
        } catch {
            XCTFail("Thrown error of incorrect type")
        }
    }
    
    func test_requestCompletesWithRemoteErrorOn500() async throws {
        // Given
        let spy = HTTPClientSpy()
        let sut = makeSUT(httpClient: spy)
        
        let expectedMessage = "Please try again"
        let remoteErrorDictionary: [String: String] = ["message": expectedMessage]
        let dummyData = try makeJSONFromDictionary(remoteErrorDictionary)
        
        /// When
        spy.completeNextRequest(withStatusCode: 500, data: dummyData)
        
        do {
            _ = try await sut.search(query: "query", type: DummyQuery(), page: 1)
            
            XCTFail("Expected RemoteDiscogsLoaderError.serverError to be thrown")
        } catch RemoteDiscogsLoaderError.serverError(let message) {
            XCTAssertEqual(message, expectedMessage)
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }
    
    func test_requestCompletesWithInvalidData() async throws {
        // Given
        let spy = HTTPClientSpy()
        let sut = makeSUT(httpClient: spy)
        let invalidData = Data("invalid-json".utf8)
        
        // When
        spy.completeNextRequest(withStatusCode: 200, data: invalidData)
        
        // Then
        do {
            _ = try await sut.search(query: "query", type: DummyQuery(), page: 1)
            XCTFail("Expected RemoteDiscogsLoaderError.invalidData to be thrown")
        } catch RemoteDiscogsLoaderError.invalidData {
            // Success
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }
    
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

struct DummyQuery: SearchQueryType {
    struct ReturnType: Codable, Equatable {
        let expectedResult: String
        
        var json: String {
            guard let data = try? JSONEncoder().encode(self) else {
                return "{}"
            }
            
            return String(data: data, encoding: .utf8) ?? "{}"
        }
    }
    
    var typeIdentifier: String {
        return "dummy"
    }
}
