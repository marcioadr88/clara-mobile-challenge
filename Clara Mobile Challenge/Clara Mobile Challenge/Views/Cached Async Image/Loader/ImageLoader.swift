//
//  ImageLoader.swift
//  Clara Mobile Challenge
//
//  Created by Marcio Duarte on 2024-12-02.
//

import UIKit

class ImageLoader: ImageLoaderProtocol {
    enum Error: Swift.Error {
        case invalidImageData
    }

    func loadImage(from url: URL) async throws -> UIImage {
        let (data, _) = try await URLSession.shared.data(from: url)
        guard let image = UIImage(data: data) else {
            throw Error.invalidImageData
        }
        return image
    }
}
