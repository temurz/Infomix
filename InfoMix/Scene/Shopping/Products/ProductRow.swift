//
//  ProductRow.swift
//  CleanArchitecture
//
//  Created by Tuan Truong on 7/21/20.
//  Copyright © 2020 Tuan Truong. All rights reserved.
//

import SwiftUI
import URLImage

struct ProductRow: View {
    let viewModel: ProductItemViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
                ZStack(alignment: .center) {
                    if let url = URL(string: self.viewModel.image ?? "") {
                        if #available(iOS 15.0, *) {
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .centerCropped()
                                    .cornerRadius(radius: 8, corners: .allCorners)
                                    
                                    .frame(width: (UIScreen.screenWidth/2) - 32 , height: (UIScreen.screenWidth/2) - 32)
//                                    .padding(.horizontal)
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
                    
                }.padding(8)
                .frame(height: (UIScreen.screenWidth/2) - 16)
                .frame(maxWidth: .infinity)
                    .cornerRadius(10)
                
                Text(viewModel.name + "\n")
                    .foregroundStyle(.black)
                    .font(.callout)
                    .multilineTextAlignment(.leading)
                    .frame(alignment: .leading)
                    .lineLimit(2)
                    .bold()
                    .padding(.horizontal)

                Text(viewModel.brandName)
                    .font(.caption).foregroundColor(.gray)
                    .padding(.horizontal)

                
                Text(viewModel.inStock ? String(viewModel.price) + " ball".localized() : "Not available now".localized()).font(.footnote)
                    .foregroundColor(viewModel.inStock ? Color.black : Color.red)
                    .bold()
                    .padding(.horizontal)

                Spacer()
                    .frame(height: 6)
                
            }.frame(maxWidth:.infinity)
                .background(Color.white)
                .cornerRadius(10)
                .padding(.vertical, 4)

    }
}

//struct ProductRow_Previews: PreviewProvider {
//    static var previews: some View {
//        let product = Product(id: 1, name: "iPhone",  price: 999, brandName: "ArtMaster")
//        return ProductRow(viewModel: ProductItemViewModel(product: product))
//    }
//}
