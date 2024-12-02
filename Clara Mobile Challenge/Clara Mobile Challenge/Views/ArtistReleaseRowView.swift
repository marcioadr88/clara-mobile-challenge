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
            AsyncImage(url: URL(string: release.thumb ?? "")) { phase in
                switch phase {
                case .empty, .failure:
                    Color.gray
                        .frame(width: 50, height: 50)
                        .cornerRadius(4)
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                        .cornerRadius(4)
                        .shadow(radius: 2)
                @unknown default:
                    EmptyView()
                }
            }
            
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
