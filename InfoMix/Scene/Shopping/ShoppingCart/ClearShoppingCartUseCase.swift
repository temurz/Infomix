//
//  ClearProductEntriesUseCase.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 11/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Foundation

protocol ClearShoppingCartUseCaseType{
    func clearShoppingCart(orderId: Int) -> Observable<Order>
}

struct ClearShoppingCartUseCase: ClearShoppingCartUseCaseType, ClearingShoppingCart {
    let shoppingGateway: ShoppingGatewayType
}
