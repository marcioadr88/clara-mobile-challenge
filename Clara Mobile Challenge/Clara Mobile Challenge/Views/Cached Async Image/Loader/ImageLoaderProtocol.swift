//
//  ImageLoaderProtocol.swift
//  Clara Mobile Challenge
//
//  Created by Marcio Duarte on 2024-12-02.
//

import UIKit

protocol ImageLoaderProtocol {
    func loadImage(from url: URL) async throws -> UIImage
}
