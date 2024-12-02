//
//  CachedAsyncImagePhase.swift
//  Clara Mobile Challenge
//
//  Created by Marcio Duarte on 2024-12-02.
//

import SwiftUI

public enum CachedAsyncImagePhase {
    case empty
    case success(Image)
    case failure(Error)
}
