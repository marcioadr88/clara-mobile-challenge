//
//  LoadingView.swift
//  Clara Mobile Challenge
//
//  Created by Marcio Duarte on 2024-12-01.
//

import SwiftUI

struct LoadingView: View {
    let message: String
    
    var body: some View {
        ProgressView(message)
            .padding()
    }
}

#Preview {
    LoadingView(message: "Loading message")
}
