//
//  GettingCurrentShoppingCart.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 06/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Combine

protocol GettingCurrentShoppingCart {
    var shoppingGateway: ShoppingGatewayType { get }
}

extension GettingCurrentShoppingCart {
    
    func currentShoppingCart() -> Observable<Order> {
        shoppingGateway.currentShoppingCart()
    }
    
}

