//
//  EmptyStateView.swift
//  Clara Mobile Challenge
//
//  Created by Marcio Duarte on 2024-12-01.
//

import SwiftUI

struct EmptyStateView: View {
    let message: String
    
    var body: some View {
        Text(message)
            .foregroundColor(.gray)
            .padding()
    }
}

#Preview {
    EmptyStateView(message: "Start typing to search")
}
