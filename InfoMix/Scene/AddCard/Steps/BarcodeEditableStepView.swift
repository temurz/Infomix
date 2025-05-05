//
//  BarcodeEditableStepView.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 15/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine
import Localize_Swift

struct BarcodeEditableStepView: AbstractStepView {
    
    @Binding var cardStepItem :AddCardStepItem
    var scanTrigger: PassthroughSubject<AddCardStepItem,Error>
    var onDelete: DeleteHandler?
    @State var dynamicHeight: CGFloat = .zero
    
    var body: some View {
        VStack {
            if let product = cardStepItem.product {
                VStack(spacing: 8) {
                    HStack {
                        Text(cardStepItem.titleLocalization())
                        Spacer()
                        Button {
                            cardStepItem.product = nil
                            scanTrigger.send(cardStepItem)
                        } label: {
                            Image(systemName: "trash.fill")
                                .scaledToFit()
                                .foregroundStyle(.black)
                                .frame(width: 24, height: 24)
                        }
                    }
                    buildDescriptionRow(title: "Serial number:".localized(), subtitle: product.serialNumber ?? "")
                    buildDescriptionRow(title: "Model".localized(), subtitle: product.modelName ?? "")
                    buildDescriptionRow(
                        title: "State".localized(),
                        subtitle: (product.accessible ?? false) ? "Ro'yxatga olingan" : "Mavjud",
                        subtitleColor: .orange
                    )
                    HStack(alignment: .top) {
                        Text("Info".localized())
                            .foregroundStyle(Color.secondary)
                            .font(.footnote)
                            .frame(width: 120, alignment: .leading)
                        WebView(dynamicHeight: $dynamicHeight, html: product.componentsHTML ?? "")
                        Spacer()
                    }
                    .frame(minHeight: dynamicHeight)
                }
                .padding()
            } else {
                HStack {
                    Text(cardStepItem.titleLocalization())
                    Spacer()
                    Menu{
                        Button("Clear", action: {
                            cardStepItem.valueString = ""
                        })
                        if cardStepItem.originaltemId != nil {
                            Button("Delete", action:{
                                onDelete?(cardStepItem)
                            })
                        }
                    } label: {
                        Image(systemName: "ellipsis")
                            .padding(10)
                    }
                }
                .padding()
                if cardStepItem.editable {
                    HStack{
                        TextField("Type here", text: $cardStepItem.valueString)
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .textFieldStyle(.roundedBorder)
                        
                        Button{
                            self.scanTrigger.send(cardStepItem)
                        } label: {
                            Image(systemName: "qrcode.viewfinder").padding(8)
                                .background(Color(red: 0.82, green: 0.82, blue: 0.82).cornerRadius(8))
                        }
                        
                        
                    }.padding()
                } else {
                    VStack{
                        Text(cardStepItem.valueString)
                        Button{
                            self.scanTrigger.send(cardStepItem)
                        } label: {
                            HStack{
                                Image(systemName: "qrcode.viewfinder")
                                Text("Scan")
                            }.padding(10)
                                .frame(maxWidth: .infinity)
                                .background(Color(red: 0.82, green: 0.82, blue: 0.82).cornerRadius(8))
                        }.padding()
                    }
                    
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 2)
        .onAppear {
            if cardStepItem.product == nil {
                scanTrigger.send(cardStepItem)
            }
        }
    }
    
    func buildDescriptionRow(title: String, subtitle: String, subtitleColor: Color = .secondary) -> some View {
        HStack(alignment: .top) {
            Text(title)
                .foregroundStyle(Color.secondary)
                .font(.footnote)
                .frame(width: 120, alignment: .leading)
            Text(subtitle)
                .foregroundStyle(subtitleColor)
            Spacer()
        }
    }
}

struct BarcodeEditableStepView_Previews: PreviewProvider {
    
    @State  static var item = AddCardStepItem()
    static var previews: some View {
        BarcodeEditableStepView(cardStepItem: $item, scanTrigger: PassthroughSubject<AddCardStepItem, Error>())
    }
}
