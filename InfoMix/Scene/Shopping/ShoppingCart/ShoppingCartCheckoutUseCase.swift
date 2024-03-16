//
//  ShoppingCartCheckoutUseCase.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 11/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Foundation

protocol ShoppingCartCheckoutUseCaseType{
    func checkout(orderId: Int) -> Observable<Order>
}

struct ShoppingCartCheckoutUseCase: ShoppingCartCheckoutUseCaseType, CheckingOutShoppingCart {
    let shoppingGateway: ShoppingGatewayType
}
