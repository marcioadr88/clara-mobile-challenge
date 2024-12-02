//
//  ReleasesButtonView.swift
//  Clara Mobile Challenge
//
//  Created by Marcio Duarte on 2024-12-02.
//

import SwiftUI

struct ReleasesButtonView: View {
    private let artistDetail: ArtistDetail
    
    init(artistDetail: ArtistDetail) {
        self.artistDetail = artistDetail
    }
    
    var body: some View {
        NavigationLink(destination: ArtistReleaseScreenView(artist: artistDetail)) {
            Text(Localizables.seeReleases)
                .fontWeight(.semibold)
        }
        .controlSize(.small)
        .buttonStyle(.bordered)
        .buttonBorderShape(.capsule)
    }
}
