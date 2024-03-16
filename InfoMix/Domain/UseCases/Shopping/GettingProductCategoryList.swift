//
//  GettingProductCategoryList.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 07/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Combine

protocol GettingProductCategoryList {
    var productCategoryGateway: ProductCategoryGatewayType { get }
}

extension GettingProductCategoryList {
    
    func getProductCategoryList(parentId: Int?) -> Observable<[ProductCategory]> {
        productCategoryGateway.getProductCategoryList(parentId: parentId)
    }
    
}

