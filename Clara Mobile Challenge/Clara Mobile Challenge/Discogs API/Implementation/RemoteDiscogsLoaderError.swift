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
