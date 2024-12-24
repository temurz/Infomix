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
            
            super.init(urlString: Urls.productsTop,
                       parameters: nil,
                       method: .get,
                       requireAccessToken: true)
            
        }
    }
    
}
