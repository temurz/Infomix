//
//  OrderStatusListUseCase.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 12/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//



import Combine

protocol OrderStatusListUseCaseType {
    func getOrderStatusList() -> Observable<[OrderStatus]>
}

struct OrderStatusListUseCase: OrderStatusListUseCaseType, GettingOrderStatusList {
    let shoppingGateway: ShoppingGatewayType
    
}

