//
//  QuickActionRow.swift
//  InfoMix
//
//  Created by Temur on 13/06/2025.
//  Copyright © 2025 InfoMix. All rights reserved.
//

import SwiftUI

struct QuickActionRow: View {
    let icon: String
    let text: String
    let color: Color
    var body: some View {
        HStack {
            Image(icon)
                .renderingMode(.template)
                .centerCropped()
                .frame(width: 24, height: 24)
                .foregroundStyle(color)
            Text(text)
                .font(.footnote)
                .bold()
                .foregroundStyle(color)
                .frame(height: 32)
            Spacer()
        }
        .padding(12)
        .background(color.opacity(0.2))
        .cornerRadius(radius: 8, corners: .allCorners)
    }
}
