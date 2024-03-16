//
//  GettingOrder.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 12/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Combine

protocol GettingOrder {
    var shoppingGateway: ShoppingGatewayType { get }
}

extension GettingOrder {
    
    func getOrder(orderId: Int) -> Observable<Order> {
        shoppingGateway.getOrder(orderId: orderId)
    }
    
}
