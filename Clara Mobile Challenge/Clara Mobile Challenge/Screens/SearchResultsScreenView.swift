//
//  SearchResultsScreenView.swift
//  Clara Mobile Challenge
//
//  Created by Marcio Duarte on 2024-12-01.
//

import SwiftUI

struct SearchResultsScreenView: View {
    @Binding var selection: ArtistSearchResult?
    
    init(selection: Binding<ArtistSearchResult?>) {
        _selection = selection
    }
    
    init() {
        _selection = Binding(get: { nil }, set: { _ in })
    }
    
    var body: some View {
        Text("Search Results Screen for \(String(describing: selection?.title))")
    }
}

#Preview {
    SearchResultsScreenView()
}
