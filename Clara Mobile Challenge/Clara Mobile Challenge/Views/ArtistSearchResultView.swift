//
//  ArtistSearchResultView.swift
//  Clara Mobile Challenge
//
//  Created by Marcio Duarte on 2024-12-01.
//

import SwiftUI

struct ArtistSearchResultView: View {
    private let artist: ArtistSearchResult
    
    init(artist: ArtistSearchResult) {
        self.artist = artist
    }
    
    var body: some View {
        HStack(alignment: .center) {
            imageContent
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            
            Text(artist.title)
                .font(.headline)
        }
    }
    
    @ViewBuilder private var imageContent: some View {
        if let url = URL(string: artist.thumb) {
            CachedAsyncImage(url: url) { phase in
                switch phase {
                case .success(let image):
                    image.resizable()
                case .failure, .empty:
                    imagePlaceholder
                }
            }
        } else {
            imagePlaceholder
        }
    }
    
    private var imagePlaceholder: some View {
        Color(uiColor: .lightGray)
    }
}

#Preview {
    VStack(alignment: .leading) {
        ArtistSearchResultView(
            artist: ArtistSearchResult(
                id: 1,
                title: "Nirvana",
                thumb: "https://i.discogs.com/KydDnAWdAzeHy0dZ4YSnpkuh__uLXIk8w60uKQVW0G4/rs:fit/g:sm/q:40/h:150/w:150/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTEyNTI0/Ni0xNTAxMjg1MjAw/LTMwNTguanBlZw.jpeg"
            )
        )
        
        ArtistSearchResultView(
            artist: ArtistSearchResult(
                id: 2,
                title: "Placeholder",
                thumb: ""
            )
        )
    }
}
