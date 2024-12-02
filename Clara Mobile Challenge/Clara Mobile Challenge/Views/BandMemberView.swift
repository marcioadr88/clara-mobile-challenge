//
//  BandMemberView.swift
//  Clara Mobile Challenge
//
//  Created by Marcio Duarte on 2024-12-02.
//

import SwiftUI

struct BandMemberView: View {
    private let member: BandMember
    
    init(member: BandMember) {
        self.member = member
    }
    
    var body: some View {
        Text("• \(member.name)")
            .font(.subheadline)
    }
}

#Preview {
    BandMemberView(member: BandMember(id: 1, name: "Member 1", active: true))
}
