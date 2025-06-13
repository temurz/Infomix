//
//  MainCellView.swift
//  InfoMix
//
//  Created by Temur on 16/12/2024.
//  Copyright © 2024 InfoMix. All rights reserved.
//

import SwiftUI
struct MainCellView: View {
    let model: MainCellModel
    var body: some View {
        ZStack {
            Colors.lightGrayColor
            VStack(alignment: .leading) {
                Text(model.title)
                    .font(.callout)
                    .foregroundStyle(Color.primary)
                    .bold()
                    .padding(.horizontal)
                    .padding(.top)
                Text(model.subtitle)
                    .font(.footnote)
                    .foregroundStyle(Color.secondary)
                    .padding(.horizontal)
                
                HStack {
                    Button {
                        
                    } label: {
                        Image(model.leftImage)
                            .renderingMode(.template)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .foregroundStyle(Colors.appMainColor)
                            .padding(8)
                    }
                    .frame(width: 32, height: 32)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(radius: 16, corners: .allCorners)
                    .padding()
                    Spacer()
                    if let rightButton = model.rightButton {
                        Button {
                            
                        } label: {
                            Image(systemName: rightButton)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundStyle(.white)
                                .padding(8)
                        }
                        .frame(width: 24, height: 24)
                        .background(Colors.appMainColor)
                        .cornerRadius(radius: 12, corners: .allCorners)
                        .padding()
                    }
                }
            }
        }
        
    }
}

enum MainCellType {
    case confirmed
    case rejected
    case earned
    case checking
    case dispute
    case products
}

struct MainCellModel {
    let type: MainCellType
    let title: String
    let subtitle: String
    let leftImage: String
    let rightButton: String? = nil
}
