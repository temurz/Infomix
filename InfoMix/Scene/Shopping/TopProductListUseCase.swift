//
//  TopProductListUseCase.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 13/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//


protocol TopProductListUseCaseType {
    func getTopProductList() -> Observable<[Product]>
}

struct TopProductListUseCase: TopProductListUseCaseType, GettingTopProducts {
    let productGateway: ProductGatewayType
    
  
}
