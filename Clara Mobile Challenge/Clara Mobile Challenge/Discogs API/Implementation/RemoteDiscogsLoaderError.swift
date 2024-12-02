//
//  RemoteDiscogsLoaderError.swift
//  Clara Mobile Challenge
//
//  Created by Marcio Duarte on 2024-11-30.
//

import Foundation

enum RemoteDiscogsLoaderError: Error {
    case invalidData
    case httpClientError(reason: Error)
    case badRequest
    case serverError(message: String?)
}

extension RemoteDiscogsLoaderError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidData:
            return Localizables.invalidDataError
        case .badRequest:
            return Localizables.badRequestError
        case .httpClientError:
            return Localizables.httpClientError
        case .serverError(let message):
            return Localizables.serverError(message ?? "")
        }
    }
    
    var failureReason: String? {
        switch self {
        case .httpClientError(let error):
            return error.localizedDescription
        default:
            return nil
        }
    }
}
