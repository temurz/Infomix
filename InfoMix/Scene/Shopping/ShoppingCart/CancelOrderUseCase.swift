//
//  CancelOrderUseCase.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 11/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Foundation

protocol CancelOrderUseCaseType{
    func cancelOrder(orderId: Int) -> Observable<Order>
}

struct CancelOrderUseCase: CancelOrderUseCaseType, CancelingOrder {
    let shoppingGateway: ShoppingGatewayType
}
