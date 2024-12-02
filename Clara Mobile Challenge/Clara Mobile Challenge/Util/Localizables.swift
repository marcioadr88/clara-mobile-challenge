//
//  Localizables.swift
//  Clara Mobile Challenge
//
//  Created by Marcio Duarte on 2024-12-02.
//

import Foundation

@dynamicMemberLookup
final class Localizables {
    private init() {}
    
    private static let stringsName = "Strings"
    
    static subscript(dynamicMember member: String) -> String {
        NSLocalizedString(
            member,
            tableName: stringsName,
            bundle: Bundle.main,
            comment: ""
        )
    }
    
    static subscript(dynamicMember member: String) -> (_ arguments: CVarArg...) -> String {
        { arguments in
            String(
                format: Localizables[dynamicMember: member],
                arguments: arguments
            )
        }
    }
}
