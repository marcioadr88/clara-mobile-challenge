//
//  ArtistDetailsContentView.swift
//  Clara Mobile Challenge
//
//  Created by Marcio Duarte on 2024-12-02.
//

import SwiftUI

struct ArtistDetailsContentView: View {
    private let artistDetail: ArtistDetail
    
    init(artistDetail: ArtistDetail) {
        self.artistDetail = artistDetail
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            ArtistDetailImageView(imageURL: artistDetail.imageURL)
            
            VStack(alignment: .center) {
                ReleasesButtonView(artistDetail: artistDetail)
            }
            .frame(maxWidth: .infinity)
            
            ArtistProfileSectionView(profile: artistDetail.profile)
            
            if let members = artistDetail.members, !members.isEmpty {
                BandMembersSectionView(members: members)
            }
        }
    }
}

#Preview {
    ArtistDetailsContentView(artistDetail:
                                ArtistDetail(
                                    id: 1,
                                    name: "Artist",
                                    profile: "A profile description",
                                    imageURL: "https://placehold.co/600x400",
                                    releasesURL: "",
                                    urls: [],
                                    members: []
                                )
    )
}
