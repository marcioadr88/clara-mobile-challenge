//
//  AsyncImageLoader.swift
//  Clara Mobile Challenge
//
//  Created by Marcio Duarte on 2024-12-02.
//

import SwiftUI

struct AsyncImageLoader<Content: View>: View {
    let url: URL
    let cache: ImageCacheProtocol
    let loader: ImageLoaderProtocol
    let content: (CachedAsyncImagePhase) -> Content
    
    @State private var phase: CachedAsyncImagePhase = .empty
    
    var body: some View {
        content(phase)
            .task {
                await loadImage()
            }
            .onChange(of: url) { _ in
                Task {
                    await loadImage()
                }
            }
    }
    
    @MainActor
    private func loadImage() async {
        if let cachedImage = cache.getImage(for: url) {
            phase = .success(Image(uiImage: cachedImage))
            return
        }
        
        do {
            let downloadedImage = try await loader.loadImage(from: url)
            cache.saveImage(downloadedImage, for: url)
            phase = .success(Image(uiImage: downloadedImage))
        } catch {
            phase = .failure(error)
        }
    }
}
