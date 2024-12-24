//
//  StatusView.swift
//  InfoMix
//
//  Created by Temur on 16/12/2024.
//  Copyright © 2024 InfoMix. All rights reserved.
//

import SwiftUI
import Localize_Swift
struct StatusView: View {
    let model: Loyalty?
    var body: some View {
        ZStack {
            RoundedCorner(color: Colors.appMainColor, tl: 0, tr: 0, bl: 0, br: 60)
                .frame(maxWidth: .infinity, maxHeight: 240)

            VStack {
                Text("Your level")
                    .foregroundStyle(Color.secondary)
                Image(model?.icon ?? "na_icon")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .cornerRadius(radius: 30, corners: .allCorners)
                Text(model?.name ?? "No level".localized())
                    .font(.body)
                    .bold()
                    .foregroundStyle(Color.primary)
                Text("Send card and get loyalty level".localized())
                    .font(.footnote)
//                if let nextLevel = model?.nextLevel {
//                    switch nextLevel {
//                    case let .loyalty(loyalty):
//                        HStack {
//                            ZStack {
//                                Colors.appMainColor
//                                    .frame(height: 24)
//                                    .cornerRadius(radius: 12, corners: .allCorners)
//                                Text("\(loyalty.amount ?? 0)" + "/" + "\(loyalty.targetCount ?? 0)")
//                            }
//                        }
//                    }
//                }
            }
            .background(.white)
            .padding()
            .cornerRadius(radius: 12, corners: .allCorners)
        }
        
    }
}
