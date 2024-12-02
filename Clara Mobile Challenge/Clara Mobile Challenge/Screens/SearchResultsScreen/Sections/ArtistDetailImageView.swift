//
//  ArtistDetailImageView.swift
//  Clara Mobile Challenge
//
//  Created by Marcio Duarte on 2024-12-02.
//

import SwiftUI

struct ArtistDetailImageView: View {
    let imageURL: String?
    
    init(imageURL: String?) {
        self.imageURL = imageURL
    }
    
    var body: some View {
        if let imageURL, let url = URL(string: imageURL) {
            CachedAsyncImage(url: url) { phase in
                switch phase {
                case .success(let image):
                    artistImage(image)
                case .failure, .empty:
                    placeholder
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
    }
    
    private func artistImage(_ image: Image) -> some View {
        image
            .resizable()
            .aspectRatio(contentMode: .fit)
            .cornerRadius(12)
            .frame(maxWidth: 400, maxHeight: 400)
            .shadow(radius: 4)
    }
    
    private var placeholder: some View {
        Color
            .gray
            .frame(width: 200, height: 200)
            .cornerRadius(12)
            .shadow(radius: 2)
    }
}

#Preview {
    ArtistDetailImageView(imageURL: "https://i.discogs.com/ypZclL3aRCjEtOU8NTTljmZA2yDB3zl9TiG5SrMUkFg/rs:fit/g:sm/q:90/h:435/w:600/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTE4ODM5/LTE1NTU4NTQxNjQt/MjM4Ny5qcGVn.jpeg")
}
