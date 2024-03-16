//
//  API+ProductList.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 08/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//



import Alamofire
import Combine

extension API {
    
    func getProductList(input: ProductListInput) -> Observable<[Product]> {
        return requestList(input)
    }
    
    final class ProductListInput: APIInput {
        init(dto: GetPageDto, categoryId: Int?, query: String?){
            
            var parameters: Parameters = [
                "page": dto.page,
                "rows": dto.perPage
                ]
            
            
            if let categoryId = categoryId {
                parameters["categoryId"] = categoryId
            }
            
            if let query = query {
                parameters["query"] = query
            }
            
            super.init(urlString: Urls.products,
                       parameters: parameters,
                       method: .post,
                       requireAccessToken: true)
            
        }
    }
    
}
