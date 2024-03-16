//
//  GettingOrderStatusList.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 12/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//


import Combine

protocol GettingOrderStatusList {
    var shoppingGateway: ShoppingGatewayType { get }
}

extension GettingOrderStatusList {
    func getOrderStatusList() -> Observable<[OrderStatus]> {
        shoppingGateway.getOrderStatusList()
    }
}
