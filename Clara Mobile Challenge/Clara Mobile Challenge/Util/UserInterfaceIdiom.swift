//
//  UserInterfaceIdiom.swift
//  Clara Mobile Challenge
//
//  Created by Marcio Duarte on 2024-12-01.
//

import SwiftUI

enum UserInterfaceIdiom {
    case phone
    case pad
    case mac
    case other
}

#if os(iOS)
import UIKit

extension UserInterfaceIdiom {
    static func from(_ idiom: UIUserInterfaceIdiom) -> UserInterfaceIdiom {
        switch idiom {
        case .pad:
            return .pad
        case .phone:
            return .phone
        case .mac:
            return .mac
        default:
            return .other
        }
    }
}
#endif

private struct UserInterfaceIdiomEnvironmentKey: EnvironmentKey {
    static var defaultValue: UserInterfaceIdiom = .phone
}

extension EnvironmentValues {
    var userInterfaceIdiom: UserInterfaceIdiom {
        get { self[UserInterfaceIdiomEnvironmentKey.self] }
        set { self[UserInterfaceIdiomEnvironmentKey.self] = newValue }
    }
}
