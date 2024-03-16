//
//  CheckingOutShoppingCart.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 11/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Combine

protocol CheckingOutShoppingCart {
    var shoppingGateway: ShoppingGatewayType { get }
}

extension CheckingOutShoppingCart {
    
    func checkout(orderId: Int) -> Observable<Order> {
        shoppingGateway.checkout(orderId: orderId)
    }
    
}
