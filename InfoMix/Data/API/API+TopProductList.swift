//
//  API+TopProductList.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 13/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//



import Alamofire
import Combine

extension API {
    
    func getTopProductList(input: TopProductListInput) -> Observable<[Product]> {
        return requestList(input)
    }
    
    final class TopProductListInput: APIInput {
        init(){
            
            let parameters: Parameters = [
                "page": 1,
                "rows": 4
                ]
            
            super.init(urlString: Urls.products,
                       parameters: parameters,
                       method: .post,
                       requireAccessToken: true)
            
        }
    }
    
}
