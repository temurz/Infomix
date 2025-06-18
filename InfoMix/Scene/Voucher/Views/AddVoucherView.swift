//
//  AddVoucherView.swift
//  InfoMix
//
//  Created by Temur on 17/06/2025.
//  Copyright © 2025 InfoMix. All rights reserved.
//

import SwiftUI
import Localize_Swift

struct AddVoucherView: View {
    @Binding var amount: String
    @Binding var errorText: String
    let balance: String
    var cancelAction: (() -> Void)?
    var requestAction: (() -> Void)?
    var body: some View {
        VStack {
            HStack {
                Text("Get balls".localized())
                    .bold()
                Spacer()
                Button {
                    cancelAction?()
                } label: {
                    Image(systemName: "x.circle")
                        .centerCropped()
                        .tint(.black)
                        .frame(width: 24, height: 24)
                }
            }
            .padding()
            
            Text("HowManyBallsNeedToBeGot".localized())
                .font(.footnote)
                .foregroundStyle(Color.secondary)
            Text(String(format: "You have %@ balls".localized(), balance))
                .font(.footnote)
                .bold()
                .foregroundStyle(.primary)
            
            HStack {
                TextField("Enter amount".localized(), text: $amount)
                    .keyboardType(.decimalPad)
                    .padding()
            }
            .background(lightGreyColor)
            .frame(height: 50)
            .cornerRadius(5.0)
            .padding(.top)
            .padding(.horizontal)
            Text(errorText)
                .font(.footnote)
                .foregroundStyle(.red)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            Button {
                requestAction?()
            } label: {
                Text("Request".localized())
                    .padding()
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .background(Colors.appMainColor)
                    .cornerRadius(radius: 12, corners: .allCorners)
            }
            .padding()
                
            
        }
        .background(.white)
        .cornerRadius(radius: 12, corners: .allCorners)
        .padding()
    }
}
