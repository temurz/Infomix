//
//  API+Checkout.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 11/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Alamofire
import Combine

extension API {
    
    func checkout(_ input: CheckoutApiInput) -> Observable<Order> {
        return request(input)
    }
    
    final class CheckoutApiInput: APIInput {
        init(orderId: Int){
            let parameters: Parameters = [
                "id": orderId]
            
            super.init(urlString: Urls.checkout,
                       parameters: parameters,
                       method: .post,
                       requireAccessToken: true)
            
        }
    }
    
}
