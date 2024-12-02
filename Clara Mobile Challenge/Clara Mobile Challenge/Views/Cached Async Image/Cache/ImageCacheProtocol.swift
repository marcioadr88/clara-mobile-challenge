//
//  ImageCacheProtocol.swift
//  Clara Mobile Challenge
//
//  Created by Marcio Duarte on 2024-12-02.
//

import UIKit

protocol ImageCacheProtocol {
    func getImage(for url: URL) -> UIImage?
    func saveImage(_ image: UIImage, for url: URL)
}
