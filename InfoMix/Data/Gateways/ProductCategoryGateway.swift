//
//  ProductCategoryGateway.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 07/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Combine
import Foundation

protocol ProductCategoryGatewayType {
    func getProductCategoryList(parentId: Int?) -> Observable<[ProductCategory]>
}

struct ProductCategoryGateway: ProductCategoryGatewayType {
    
    func getProductCategoryList(parentId: Int?) -> Observable<[ProductCategory]> {
        let input = API.ProductCategoryListInput(parentId: parentId)
        
        return API.shared.getProductCategoryList(input: input)
            .eraseToAnyPublisher()
    }

}

struct PreviewProductCategoryGateway: ProductCategoryGatewayType {
    func getProductCategoryList(parentId: Int?) -> Observable<[ProductCategory]> {
        Future<[ProductCategory], Error> { promise in
            promise(.success([ProductCategory]()))
        }
        .eraseToAnyPublisher()
    }
}
