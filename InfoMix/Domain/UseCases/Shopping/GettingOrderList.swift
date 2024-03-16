//
//  GettingOrderList.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 12/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Combine

protocol GettingOrderList {
    var shoppingGateway: ShoppingGatewayType { get }
}

extension GettingOrderList {
    func getOrderList(dto: GetPageDto, input: GetOrdersInput) -> Observable<PagingInfo<Order>> {
        shoppingGateway.getOrders(dto: dto, from: input.from, to: input.to, status: input.status=="all" ? nil : input.status)
    }
}
