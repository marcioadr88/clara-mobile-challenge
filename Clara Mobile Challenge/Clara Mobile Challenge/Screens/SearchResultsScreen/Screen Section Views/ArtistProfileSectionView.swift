//
//  ArtistProfileSectionView.swift
//  Clara Mobile Challenge
//
//  Created by Marcio Duarte on 2024-12-02.
//

import SwiftUI

struct ArtistProfileSectionView: View {
    private let profile: String?
    
    init(profile: String?) {
        self.profile = profile
    }
    
    var body: some View {
        if let profile, !profile.isEmpty {
            Text(profile)
                .font(.body)
                .foregroundColor(.primary)
                .multilineTextAlignment(.leading)
                .lineSpacing(5)
        } else {
            Text("No profile data")
        }
    }
}

#Preview {
    VStack {
        ArtistProfileSectionView(profile: "A text about the artist profile")
        ArtistProfileSectionView(profile: nil)
    }
}
