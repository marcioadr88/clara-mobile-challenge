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

extension ArtistDetail {
    enum CodingKeys: String, CodingKey {
        case id, name, profile, urls, members
        case imageURL = "images"
        case releasesURL = "releases_url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        profile = try container.decodeIfPresent(String.self, forKey: .profile)
        releasesURL = try container.decode(String.self, forKey: .releasesURL)
        urls = try container.decodeIfPresent([String].self, forKey: .urls)
        members = try container.decodeIfPresent([BandMember].self, forKey: .members)
        
        if let images = try container.decodeIfPresent([Image].self, forKey: .imageURL),
           let firstImage = images.first {
            imageURL = firstImage.resourceURL
        } else {
            imageURL = nil
        }
    }
}

private struct Image: Codable {
    let resourceURL: String
    
    enum CodingKeys: String, CodingKey {
        case resourceURL = "resource_url"
    }
}
