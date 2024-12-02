//
//  ArtistRelease.swift
//  Clara Mobile Challenge
//
//  Created by Marcio Duarte on 2024-12-02.
//

import Foundation

struct ArtistRelease: Decodable, Identifiable {
    let id: Int
    let type: String
    let format: String
    let label: String
    let title: String
    let year: Int
    let thumb: String
}
