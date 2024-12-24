//
//  ShoppingCartEntryView.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 10/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import SwiftUI
import URLImage

struct ShoppingCartEntryView: View {
    @Binding var entry: ProductEntry
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
                    }
                    
                    Spacer()
                    HStack {
                        HStack {
                            
                            Text(String(self.entry.quantity) + " items".localized())
                                .font(.system(size: 13))
                                .foregroundColor(.black)
                                .padding(5)
                            
                        }
                        .background(Color.init(.systemGray6))
                        .cornerRadius(5)
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
    
    
}
//
//struct ShoppingCartEntryView_Previews: PreviewProvider {
//    static var previews: some View {
//        ShoppingCartEntryView(entry: .constant(ProductEntry(id: 1, salesPrice: 10.0, quantity: 6, product: Product(id: 1, name: "Product 1", price: 10.0, brandName: "ArtMaster", inStock: 1, description: "", content: "")))) 
//
//    }
//}
