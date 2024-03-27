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
               
                ZStack{
                    if let url = URL(string: self.viewModel.image ?? "") {
                        if #available(iOS 15.0, *) {
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
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
                .frame(width: UIScreen.main.bounds.width / 2 - 40, height: 190)
                    .cornerRadius(10)
                
                Text(viewModel.name)
                    .bold()
                
                Text(viewModel.brandName)
                    .font(.caption2).foregroundColor(.gray)
                
                
                Text(viewModel.inStock ? String(viewModel.price) + " ball".localized() : "Not available now".localized()).font(.caption)
                    .foregroundColor(viewModel.inStock ? Color.green : Color.red)
                
                Spacer()
                    .frame(height: 6)
                
            }.frame(maxWidth:.infinity)
                .background(Color.white)
                .cornerRadius(10)
        
    }
}

struct ProductRow_Previews: PreviewProvider {
    static var previews: some View {
        let product = Product(id: 1, name: "iPhone",  price: 999, brandName: "ArtMaster")
        return ProductRow(viewModel: ProductItemViewModel(product: product))
    }
}
