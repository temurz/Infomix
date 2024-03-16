//
//  GetBonusUseCase.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 05/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//


import Combine

protocol AddToCartUseCaseType {
    func addToCart(input: AddToCartInput) -> Observable<Order>
}

struct AddToCartUseCase: AddToCartUseCaseType, AddingToCart {
    let shoppingGateway: ShoppingGatewayType
    
}

struct AddToCartInput {
    let product: Product
    let quantity: Int
}
