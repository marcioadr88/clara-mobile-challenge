//
//  ArtistDetail.swift
//  Clara Mobile Challenge
//
//  Created by Marcio Duarte on 2024-11-30.
//

import Foundation

struct ArtistDetail: Decodable {
    let id: Int
    let name: String
    let profile: String?
    let imageURL: String?
    let releasesURL: String
    let urls: [String]?
    let members: [BandMember]?
}

