//
//  ProductGateway.swift
//  CleanArchitecture
//
//  Created by Tuan Truong on 7/14/20.
//  Copyright © 2020 Tuan Truong. All rights reserved.
//

import Combine
import Foundation

protocol ProductGatewayType {
    func getProducts(dto: GetPageDto, categoryId: Int?, query: String?) -> Observable<PagingInfo<Product>>
    func getTopProductList() -> Observable<[Product]>
}

struct ProductGateway: ProductGatewayType {
    func getTopProductList() -> Observable<[Product]> {
        let input = API.TopProductListInput()
        
        
        return API.shared.getTopProductList(input: input)
    
    }
    
    func getProducts(dto: GetPageDto, categoryId: Int?, query: String?) -> Observable<PagingInfo<Product>> {
        let input = API.ProductListInput(dto: dto, categoryId: categoryId, query: query)
        
        
        return API.shared.getProductList(input: input)
            .map { (output) -> [Product]? in
            return output
        }
        .replaceNil(with: [])
        .map { PagingInfo(page: dto.page, items: $0, hasMorePages: $0.count == dto.perPage) }
        .eraseToAnyPublisher()
    
    }
    
    
}

struct PreviewProductGateway: ProductGatewayType {
    func getTopProductList() -> Observable<[Product]> {
        Future<[Product], Error> { promise in
            let products = [
                Product(id: 0, name: "iPhone", price: 999),
                Product(id: 1, name: "MacBook", price: 2999)
            ]
            
            promise(.success(products))
        }
        .eraseToAnyPublisher()
    }
    
    func getProducts(dto: GetPageDto, categoryId: Int?, query: String?) -> Observable<PagingInfo<Product>> {
        Future<PagingInfo<Product>, Error> { promise in
            let products = [
                Product(id: 0, name: "iPhone", price: 999),
                Product(id: 1, name: "MacBook", price: 2999)
            ]
            
            promise(.success(PagingInfo(page: 1, items: products)))
        }
        .eraseToAnyPublisher()
    }
}
