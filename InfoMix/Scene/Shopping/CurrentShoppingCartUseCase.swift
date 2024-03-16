//
//  CurrentShoppingCartUseCase.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 06/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//


protocol CurrentShoppingCartUseCaseType {
    func currentShoppingCart() -> Observable<Order>
}

struct CurrentShoppingCartUseCase: CurrentShoppingCartUseCaseType, GettingCurrentShoppingCart {
    let shoppingGateway: ShoppingGatewayType
    
  
}
