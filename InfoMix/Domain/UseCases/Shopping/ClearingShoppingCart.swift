//
//  ClearingShoppingCart.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 11/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Combine

protocol ClearingShoppingCart {
    var shoppingGateway: ShoppingGatewayType { get }
}

extension ClearingShoppingCart {
    
    func clearShoppingCart(orderId: Int) -> Observable<Order> {
        shoppingGateway.clearShoppingCart(orderId: orderId)
    }
    
}
