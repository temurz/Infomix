//
//  HistoryCell.swift
//  InfoMix
//
//  Created by Temur on 17/06/2025.
//  Copyright © 2025 InfoMix. All rights reserved.
//

import SwiftUI
import Localize_Swift

struct HistoryCell: View {
    let model: VoucherHistoryResponse
    var cancelAction: (() -> Void)?
    var getBarcodeAction: (() -> Void)?
    
    var body: some View {
        VStack {
            HStack {
                InformationView(title: "Created date".localized(), subtitle: model.createDate?.formatTimestamp() ?? "")
                    .frame(width: UIScreen.screenWidthWithMargins/2)
                InformationView(title: "Paid date".localized(), subtitle: model.paidDate?.formatTimestamp() ?? "")
                    .frame(width: UIScreen.screenWidthWithMargins/2)
            }
            VStack(alignment: .leading) {
                HStack {
                    InformationView(title: "Ball".localized(), subtitle: "\(model.amount ?? 0)" + " ball" )
                        .frame(width: UIScreen.screenWidthWithMargins/2)
                    InformationView(title: "Paid date".localized(), subtitle: "\(model.totalAmount ?? 0)" + " so'm")
                        .frame(width: UIScreen.screenWidthWithMargins/2)
                }
                Text("NotePointPrice".localized())
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
            .padding(.horizontal)
            .background(Colors.lightGrayColor)
            HStack {
                Text("Request: ".localized() + (model.code ?? ""))
                    .font(.footnote)
                    .bold()
                    .foregroundStyle(Color.secondary)
                Spacer()
                if model.status != "Canceled" {
                    if model.confirmed ?? false {
                        Button {
                            getBarcodeAction?()
                        } label: {
                            Text("How to get?".localized())
                        }
                    } else {
                        Button {
                            cancelAction?()
                        } label: {
                            Text("Cancel".localized())
                        }
                    }

                }
            }
            
        }
        .padding(.horizontal)
    }
}

struct InformationView: View {
    let title: String
    let subtitle: String
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.footnote)
                    .foregroundStyle(.gray)
                Text(subtitle)
                    .foregroundStyle(.primary)
                    .bold()
            }
            Spacer()
        }
        .padding(4)
    }
}
