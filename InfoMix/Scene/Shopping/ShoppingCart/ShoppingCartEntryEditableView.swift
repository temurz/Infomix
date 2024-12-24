//
//  ShoppingCartEntryView.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 10/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import SwiftUI
import URLImage

struct ShoppingCartEntryEditableView: View {
    @Binding var entry: ProductEntry
    @Binding var updating: Bool
    let update: (_ entryId: Int, _ newQuantity: Int)->Void
    let delete: (_ entryId: Int)->Void
    var body: some View {
        ZStack() {
            HStack(alignment: .top) {
                ZStack{
                    if let imageUrl =  entry.productImage {
                    if let url = URL(string: imageUrl) {
                        if #available(iOS 15.0, *) {
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .centerCropped()
                                    .frame(width: 96, height: 96)
                                    .cornerRadius(radius: 8, corners: .allCorners)
                            } placeholder: {
                                ProgressView()
                            }
                        } else {
                            
                            AsyncImageEarly(
                                url: url,
                                placeholder: { ProgressView() },
                                image: { Image(uiImage: $0)
                                    .resizable()
                                }
                            )
                        }
                    }
                    
                }}
                .padding(6)
                .frame(width: 90, height: 100)
                
                VStack(alignment: .leading, spacing: 0) {
                    HStack(alignment: .top) {
                        Text(entry.productName ?? "")
                            .font(.body)
                            .foregroundColor(.black)
                            .lineLimit(2)
                        Spacer()
                        Button(action: {
                            self.delete(self.entry.id)
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(.gray)
                                .padding(.vertical, 5)
                        }
                    }
                    
                    Spacer()
                    HStack {
                        HStack {
                            minusButton()
                            Text(String(self.entry.quantity))
                                .font(.system(size: 13))
                                .foregroundColor(.black)
                                .padding(.horizontal, 5)
                            plusButton()
                        }
                        .background(Color.init(.systemGray6))
                        .cornerRadius(5)
                        .padding(.bottom, 10)
                        Spacer()
                        Text("\((Double(self.entry.quantity) * (self.entry.price ?? 0)).groupped(fractionDigits: 0, groupSeparator: " ")) ball")
                            .font(.body)
                            .bold()
                            .foregroundColor(.black)
                    }
                    
                }
                .padding(.init(top: 5, leading: 5, bottom: 5, trailing: 0))
                Spacer()
            }
            .frame(height: 110)
            .padding(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
    }
    
    fileprivate func plusButton() -> some View {
        return Button(action: {
            let newQuantity = self.entry.quantity + 1
            self.update(self.entry.id, newQuantity)
        }) {
            Image(systemName: "plus")
                .foregroundColor(.gray)
                .frame(width: 25, height: 25)
        }.disabled(updating)
    }
    
    fileprivate func minusButton() -> some View {
        return Button(action: {
            var newQuantity = self.entry.quantity - 1
            if newQuantity < 1 {
                newQuantity = 1
            }
            self.update(self.entry.id, newQuantity)
        }) {
            Image(systemName: "minus")
                .foregroundColor(.gray)
                .frame(width: 25, height: 25)
        }.disabled(updating)
            
    }
    
}
