//
//  CancelingOrder.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 11/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Combine

protocol CancelingOrder {
    var shoppingGateway: ShoppingGatewayType { get }
}

extension CancelingOrder {
    
    func cancelOrder(orderId: Int) -> Observable<Order> {
        shoppingGateway.cancelOrder(orderId: orderId)
    }
    
}
