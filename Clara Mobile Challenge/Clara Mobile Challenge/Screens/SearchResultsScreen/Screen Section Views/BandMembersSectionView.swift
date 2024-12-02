//
//  BandMembersSectionView.swift
//  Clara Mobile Challenge
//
//  Created by Marcio Duarte on 2024-12-02.
//

import SwiftUI

struct BandMembersSectionView: View {
    private let members: [BandMember]
    
    init(members: [BandMember]) {
        self.members = members
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Band Members")
                .font(.title2)
                .fontWeight(.bold)
            
            ForEach(members, id: \.id) { member in
                BandMemberView(member: member)
            }
        }
    }
}
