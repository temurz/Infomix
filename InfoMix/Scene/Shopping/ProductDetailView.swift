//
//  ProductDetailView.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 10/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import SwiftUI
import URLImage

struct ProductDetailView: View {
    
    @State var index = 0
    @Binding var productItemModel: ProductItemViewModel
    @Binding var quantity: Int
    @Binding var isLoading: Bool
    let action: ()->Void
    let urlImageService = URLImageService(fileStore: nil, inMemoryStore: URLImageStore.memory)
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading){
                   
                        ImageSlider()
                  
                    
                    Text(self.productItemModel.name)
                        .font(.headline)
                    
                        .padding([.horizontal], 15)
                        .padding(.top, 8)
                    
                    
                    Text(self.productItemModel.brandName)
                        .font(.subheadline)
                        .padding([.horizontal], 15)
                        .padding(.top, 8)
                    
                    Divider()
                    
                    
                    Text(self.productItemModel.product.description)
                        .font(.subheadline)
                        .padding([.horizontal], 15)
                        .padding(.top, 8)
                }
                
            }
            Divider()
            if self.productItemModel.inStock {
                VStack (spacing: 12){
                    HStack {
                        
                        Text("\((Double(self.quantity) * self.productItemModel.product.price).groupped(fractionDigits: 0, groupSeparator: " ")) ball")
                        
                        
                        Spacer()
                        
                        HStack {
                            minusButton()
                            Text(String(self.quantity))
                            
                                .foregroundColor(.black)
                                .padding(.horizontal, 5)
                            plusButton()
                        }
                        .background(Color(.systemGray6))
                        .cornerRadius(5)
                        
                    }
                    .padding(.horizontal)
                    
                    if isLoading {
                        ProgressView()
                            .progressViewStyle(.circular)
                            .padding()
                    } else {
                        Button {
                            self.action()
                        } label: {
                            HStack{
                                Spacer()
                                Text("Add to cart".localized())
                                Image(systemName: "cart.badge.plus")
                                Spacer()
                            }
                            .padding(12)
                            .background(Color.green)
                            .foregroundColor(Color.white)
                            .cornerRadius(5)
                            .frame(maxWidth: .infinity)
                        }.padding(.horizontal)
                            .frame(maxWidth: .infinity)
                    }
                    
                }.padding(4)
            }else {
                Text("Not available now".localized()).foregroundColor(.red)
            }
            
        }.environment(\.urlImageService, urlImageService)
            .environment(\.urlImageOptions, URLImageOptions(loadOptions: [ .loadImmediately]))
        
    }
    
    
    fileprivate func ImageSlider() -> some View {
        return PagingView(index: $index.animation(.easeOut), maxIndex: self.productItemModel.images.count - 1) {
            ForEach(self.productItemModel.images, id: \.self) { imageUrl in
                ZStack{
                    if let url = URL(string: imageUrl) {
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
                    
                }.frame(width: UIScreen.main.bounds.width, height: 250)
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: 250)
        
    }
    
    
    
    fileprivate func plusButton() -> some View {
        return Button(action: {
            let inStock = Int(self.productItemModel.product.inStock)
            let newQuantity = self.quantity + 1
            
            if newQuantity > inStock {
                self.quantity = inStock
            }else{
                self.quantity = newQuantity
            }
        }) {
            Image(systemName: "plus")
                .foregroundColor(.gray)
                .frame(width: 32, height: 32)
        }
    }
    
    fileprivate func minusButton() -> some View {
        return Button(action: {
            
            let newQuantity = self.quantity - 1
            
            if newQuantity < 1 {
                self.quantity = 1
            }else{
                self.quantity = newQuantity
            }
        }) {
            Image(systemName: "minus")
                .foregroundColor(.gray)
                .frame(width: 32, height: 32)
        }
    }
    
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(productItemModel: .constant(ProductItemViewModel(product: Product())), quantity: .constant(1), isLoading: .constant(false)) { }
    }
}
