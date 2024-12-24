//
//  ProductItemViewModel.swift
//  CleanArchitecture
//
//  Created by Tuan Truong on 7/21/20.
//  Copyright © 2020 Tuan Truong. All rights reserved.
//

struct ProductItemViewModel : Identifiable {
    let id: Int
    let product: Product
    let name: String
    let price: String
    let image: String?
    let brandName: String
    let inStock: Bool
    let images: [String]
    
    
    init(product: Product) {
        self.product = product
        self.id = product.id
        self.name = product.name ?? ""
        self.price = product.price.groupped(fractionDigits: 0, groupSeparator: " ")
        self.image = product.image
        self.brandName = product.brandName ?? ""
        self.inStock = product.inStock > 0.0 && product.price > 0.0
        self.images = product.images?.filter{$0.originalImage != nil }.map{$0.originalImage!} ?? [String]()
        
    }
    
}
