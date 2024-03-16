//
//  API+ProductCategoryList.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 07/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//


import Alamofire
import Combine

extension API {
    
    func getProductCategoryList(input: ProductCategoryListInput) -> Observable<[ProductCategory]> {
        return requestList(input)
    }
    
    final class ProductCategoryListInput: APIInput {
        init(parentId: Int?){
            
            super.init(urlString: Urls.productCategories + String(parentId ?? 0),
                       parameters: nil,
                       method: .get,
                       requireAccessToken: true)
            
        }
    }
    
}


