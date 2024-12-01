//
//  HTTPClientSpy.swift
//  Clara Mobile ChallengeTests
//
//  Created by Marcio Duarte on 2024-11-30.
//

import Foundation
@testable import Clara_Mobile_Challenge

class HTTPClientSpy: HTTPClient {
    enum HTTPClientSpyError: Error {
        case completionNotDefined
    }
    
    typealias Completion = Result<(Int, Data), Error>
    
    private var completion: Completion?
    
    func request(_ request: URLRequest) async throws -> (Data, HTTPURLResponse) {
        return try await withCheckedThrowingContinuation { continuation in
            switch completion {
            case .success(let (statusCode, data)):
                let response = HTTPURLResponse(url: request.url!,
                                               statusCode: statusCode,
                                               httpVersion: nil,
                                               headerFields: nil)!
                
                continuation.resume(returning: (data, response))
            case .failure(let error):
                continuation.resume(throwing: error)
            case .none:
                continuation.resume(throwing: HTTPClientSpyError.completionNotDefined)
            }
        }
    }
    
    func completeNextRequest(withStatusCode code: Int, data: Data) {
        completion = .success((code, data))
    }
    
    func completeNextRequest(with error: Error, file: StaticString = #filePath, line: UInt = #line) {
        completion = .failure(error)
    }
}
