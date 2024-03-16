//
//  AddingToCard.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 05/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Combine

protocol AddingToCart {
    var shoppingGateway: ShoppingGatewayType { get }
}

extension AddingToCart {
    
    func addToCart(input: AddToCartInput) -> Observable<Order> {
        shoppingGateway.addToCart(product: input.product, quantity: input.quantity)
    }
    
}

