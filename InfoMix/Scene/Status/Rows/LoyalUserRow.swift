//
//  LocalUserRow.swift
//  InfoMix
//
//  Created by Temur A. Zaitov on 25/12/24.
//  Copyright © 2024 InfoMix. All rights reserved.
//

import SwiftUI
struct LoyalUserRow: View {
    let loyalUser: LoyalUser
    var body: some View {
        HStack {
            Text("\(loyalUser.position ?? 0)")
                .bold()
                .padding()
            VStack(alignment: .leading) {
                Text(loyalUser.fullName ?? "")
                    .bold()
                Text(loyalUser.cityName ?? "")
                    .font(.footnote)
            }
            .padding(.vertical)
            Spacer()
            Text("\(loyalUser.serialCardCount ?? 0)")
                .font(.footnote)
                .bold()
                .padding()
        }
    }
}
