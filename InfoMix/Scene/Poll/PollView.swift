//
//  PollView.swift
//  InfoMix
//
//  Created by Temur A. Zaitov on 21/12/24.
//  Copyright © 2024 InfoMix. All rights reserved.
//

import SwiftUI
struct PollView: View {
    var body: some View {
        VStack {
            CustomNavigationBar(title: "Poll".localized(), backButtonColor: .clear) {}
                .padding(.top)

            VStack {
                Spacer()
                EmptyDataView()
                Spacer()
            }
            Spacer()
        }
        .padding(.top)
    }
}

struct EmptyDataView: View {
    var body: some View {
        VStack {
            Text("Here will appear polls".localized())
                .foregroundStyle(.gray)
                .font(.title3)
                .bold()
                .padding()
            Image("folder_open")
                .resizable()
                .frame(width: 48, height: 48)
        }
    }
}
