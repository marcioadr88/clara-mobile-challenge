//
//  RemoteDiscogsLoaderEnvironmentKey.swift
//  Clara Mobile Challenge
//
//  Created by Marcio Duarte on 2024-12-01.
//

import SwiftUI

struct RemoteDiscogsLoaderKey: EnvironmentKey {
    static var defaultValue: DiscogsLoader = NullDiscogsLoader()
}

extension EnvironmentValues {
    var remoteDiscogsLoader: DiscogsLoader {
        get { self[RemoteDiscogsLoaderKey.self] }
        set { self[RemoteDiscogsLoaderKey.self] = newValue }
    }
}
