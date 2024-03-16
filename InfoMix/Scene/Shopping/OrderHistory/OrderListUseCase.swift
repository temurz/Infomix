//
//  GetOrderUseCase.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 12/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//


import Combine

protocol OrderListUseCaseType {
    func getOrderList(input: GetOrdersInput, page: Int) -> Observable<PagingInfo<Order>>
}

struct OrderListUseCase: OrderListUseCaseType, GettingOrderList {
    
    let shoppingGateway: ShoppingGatewayType
    
    func getOrderList(input: GetOrdersInput, page: Int) -> Observable<PagingInfo<Order>>{
        let dto = GetPageDto(page: page, perPage: 10)
        return getOrderList(dto: dto, input: input)
    }
}


struct GetOrdersInput {
    let status: String?
    let from: String?
    let to: String?
}
