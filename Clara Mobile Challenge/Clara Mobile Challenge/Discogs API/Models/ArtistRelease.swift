//
//  ArtistRelease.swift
//  Clara Mobile Challenge
//
//  Created by Marcio Duarte on 2024-12-02.
//

import Foundation

struct ArtistRelease: Decodable, Equatable, Identifiable {
    let id: UInt
    let type: String?
    let format: String?
    let label: String?
    let title: String?
    let year: Int?
    let thumb: String?
}
