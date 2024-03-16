//
//  API+CancelOrder.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 11/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//


import Alamofire
import Combine

extension API {
    
    func cancelOrder(_ input: CancelOrderApiInput) -> Observable<Order> {
        return request(input)
    }
    
    final class CancelOrderApiInput: APIInput {
        init(orderId: Int){
            let parameters: Parameters = [
                "id": orderId]
            
            super.init(urlString: Urls.cancelOrder,
                       parameters: parameters,
                       method: .post,
                       requireAccessToken: true)
            
        }
    }
    
}
