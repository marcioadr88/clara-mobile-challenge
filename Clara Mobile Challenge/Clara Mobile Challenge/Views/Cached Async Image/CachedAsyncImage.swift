//
//  CachedAsyncImage.swift
//  Clara Mobile Challenge
//
//  Created by Marcio Duarte on 2024-12-02.
//

import SwiftUI
import UIKit

struct CachedAsyncImage<Content: View>: View {
    private let url: URL?
    private let cache: ImageCacheProtocol
    private let loader: ImageLoaderProtocol
    private let content: (CachedAsyncImagePhase) -> Content
    
    init(
        url: URL?,
        cache: ImageCacheProtocol = InMemoryImageCache.shared,
        loader: ImageLoaderProtocol = ImageLoader(),
        @ViewBuilder content: @escaping (CachedAsyncImagePhase) -> Content
    ) {
        self.url = url
        self.cache = cache
        self.loader = loader
        self.content = content
    }
    
    var body: some View {
        if let url {
            AsyncImageLoader(
                url: url,
                cache: cache,
                loader: loader,
                content: content
            )
        } else {
            content(.empty)
        }
    }
}

extension CachedAsyncImage {
    init(
        url: URL?,
        @ViewBuilder content: @escaping (CachedAsyncImagePhase) -> Content
    ) {
        self.init(
            url: url,
            cache: InMemoryImageCache.shared,
            loader: ImageLoader(),
            content: content
        )
    }
}
