//
//  API+ClearShoppingCart.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 11/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Alamofire
import Combine

extension API {
    
    func clearShoppingCart(_ input: ClearShoppingCartApiInput) -> Observable<Order> {
        return request(input)
    }
    
    final class ClearShoppingCartApiInput: APIInput {
        init(orderId: Int){
            let parameters: Parameters = [
                "orderId": orderId]
            
            super.init(urlString: Urls.clearProductEntries,
                       parameters: parameters,
                       method: .post,
                       requireAccessToken: true)
            
        }
    }
    
}
