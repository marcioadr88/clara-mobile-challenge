//
//  ContentView.swift
//  Clara Mobile Challenge
//
//  Created by Marcio Duarte on 2024-11-30.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.horizontalSizeClass)
    var horizontalSizeClass
    
    @Environment(\.userInterfaceIdiom)
    var userInterfaceIdiom
    
    var body: some View {
        sizeClassBasedView()
    }
    
    @ViewBuilder
    func sizeClassBasedView() -> some View {
        Group {
            if horizontalSizeClass == .compact {
                NavigationView {
                    SearchScreenView()
                }
            } else {
                HStack {
                    SearchScreenView()
                        .frame(maxWidth: 300)
                    
                    SearchResultsScreenView()
                        .frame(maxWidth: .infinity)
                }
            }
        }
    }
    
    @ViewBuilder
    func idiomBasedView() -> some View {
        switch userInterfaceIdiom {
        case .pad, .mac:
            NavigationView {
                SearchScreenView()
                SearchResultsScreenView()
            }
            
        default:
            NavigationView {
                SearchScreenView()
            }
        }
    }
}

#Preview {
    ContentView()
}
