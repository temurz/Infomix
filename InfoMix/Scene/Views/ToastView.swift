//
//  ToastView.swift
//  InfoMix
//
//  Created by Temur A. Zaitov on 25/12/24.
//  Copyright © 2024 InfoMix. All rights reserved.
//
import SwiftUI
struct ToastView: View {
    let message: String

    var body: some View {
        Text(message)
            .foregroundColor(.white)
            .padding()
            .background(Color.black.opacity(0.8))
            .cornerRadius(10)
            .shadow(radius: 10)
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity)
    }
}
