//
//  GettingTopProductList.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 13/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//
import Combine

protocol GettingTopProducts {
    var productGateway: ProductGatewayType { get }
}

extension GettingTopProducts {
    func getTopProductList() -> Observable<[Product]> {
        return productGateway.getTopProductList()
    }
}
