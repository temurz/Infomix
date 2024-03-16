//
//  API+CurrentShoppingCart.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 06/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//


import Alamofire
import Combine

extension API {
    
    func currentShoppingCart(_ input: CurrentShoppingCartInput) -> Observable<Order> {
        return request(input)
    }
    
    final class CurrentShoppingCartInput: APIInput {
        init(){
            
            super.init(urlString: Urls.currentShoppingCart,
                       parameters: nil,
                       method: .get,
                       requireAccessToken: true)
            
        }
    }
    
}


