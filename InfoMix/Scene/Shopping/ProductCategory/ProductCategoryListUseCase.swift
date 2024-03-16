//
//  ProductCategoryListUseCase.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 07/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//


protocol ProductCategoryUseCaseType {
    func getProductCategoryList(parentId: Int?) -> Observable<[ProductCategory]>
}

struct ProductCategoryUseCase: ProductCategoryUseCaseType, GettingProductCategoryList {
    let productCategoryGateway: ProductCategoryGatewayType
  
}
