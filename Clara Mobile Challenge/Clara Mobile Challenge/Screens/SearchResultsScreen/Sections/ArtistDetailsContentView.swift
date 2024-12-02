//
//  ArtistDetailsContentView.swift
//  Clara Mobile Challenge
//
//  Created by Marcio Duarte on 2024-12-02.
//

import SwiftUI

struct ArtistDetailsContentView: View {
    private let details: ArtistDetail
    
    init(details: ArtistDetail) {
        self.details = details
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            ArtistDetailImageView(imageURL: details.imageURL)
            
            VStack(alignment: .center) {
                ReleasesButtonView()
            }
            .frame(maxWidth: .infinity)
            
            ArtistProfileSectionView(profile: details.profile)
            
            if let members = details.members, !members.isEmpty {
                BandMembersSectionView(members: members)
            }
        }
    }
}

#Preview {
    ArtistDetailsContentView(details: ArtistDetail(id: 1,
                                                   name: "Artist",
                                                   profile: "A profile description",
                                                   imageURL: "https://placehold.co/600x400",
                                                   releasesURL: "",
                                                   urls: [],
                                                   members: []))
}
