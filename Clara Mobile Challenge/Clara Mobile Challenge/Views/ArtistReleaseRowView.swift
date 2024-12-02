//
//  ArtistReleaseRowView.swift
//  Clara Mobile Challenge
//
//  Created by Marcio Duarte on 2024-12-02.
//

import SwiftUI

struct ArtistReleaseRowView: View {
    let release: ArtistRelease
    
    var body: some View {
        HStack(spacing: 16) {
            ArtistReleaseImageView(url: URL(string: release.thumb ?? ""))
            
            VStack(alignment: .leading, spacing: 4) {
                if let title = release.title {
                    Text(title)
                        .font(.headline)
                        .lineLimit(2)
                }
                
                if let label = release.label {
                    Text(label)
                        .font(.subheadline)
                        .lineLimit(1)
                }
                
                if let year = release.year {
                    Text(String(format: "%d", year))
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
        }
        .padding(.vertical, 8)
    }
}

struct ArtistReleaseImageView: View {
    private let url: URL?
    
    init(url: URL?) {
        self.url = url
    }
    
    var body: some View {
        if let url {
            CachedAsyncImage(url: url) { phase in
                switch phase {
                case .empty, .failure:
                    placeholder
                case .success(let image):
                    albumImage(image: image)
                }
            }
        } else {
            placeholder
        }
    }
    
    func albumImage(image: Image) -> some View {
        image
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 50, height: 50)
            .cornerRadius(4)
            .shadow(radius: 2)
    }
    
    var placeholder: some View {
        Color.gray
            .frame(width: 50, height: 50)
            .cornerRadius(4)
    }
}
