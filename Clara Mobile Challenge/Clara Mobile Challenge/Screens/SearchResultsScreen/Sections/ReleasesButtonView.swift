//
//  ReleasesButtonView.swift
//  Clara Mobile Challenge
//
//  Created by Marcio Duarte on 2024-12-02.
//

import SwiftUI

struct ReleasesButtonView: View {
    var body: some View {
        NavigationLink(destination: Text("")) {
            Text(Localizables.seeReleases)
                .fontWeight(.semibold)
        }
        .controlSize(.small)
        .buttonStyle(.bordered)
        .buttonBorderShape(.capsule)
    }
}

#Preview {
    ReleasesButtonView()
}
