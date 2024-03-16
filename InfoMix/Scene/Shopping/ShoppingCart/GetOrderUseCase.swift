//
//  GetOrderUseCase.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 12/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Foundation

protocol GetOrderUseCaseType{
    func getOrder(orderId: Int) -> Observable<Order>
}

struct GetOrderUseCase: GetOrderUseCaseType, GettingOrder {
    let shoppingGateway: ShoppingGatewayType
}
