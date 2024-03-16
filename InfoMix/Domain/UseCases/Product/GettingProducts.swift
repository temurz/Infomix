//
//  GettingProducts.swift
//  CleanArchitecture
//
//  Created by Tuan Truong on 7/14/20.
//  Copyright © 2020 Tuan Truong. All rights reserved.
//

import Combine

protocol GettingProducts {
    var productGateway: ProductGatewayType { get }
}

extension GettingProducts {
    func getProducts(input: GetProductsInput, page: Int) -> Observable<PagingInfo<Product>> {
        let dto  = GetPageDto(page: page, perPage: 10)
        return productGateway.getProducts(dto: dto, categoryId: input.categoryId, query: input.query)
    }
}
