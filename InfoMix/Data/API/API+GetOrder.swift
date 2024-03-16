//
//  API+GetOrder.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 12/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Alamofire
import Combine

extension API {
    
    func getOrder(_ input: GetOrderApiInput) -> Observable<Order> {
        return request(input)
    }
    
    final class GetOrderApiInput: APIInput {
        
        init(orderId:Int){
           
            
            super.init(urlString: Urls.getOrder + String(orderId),
                       parameters: nil,
                       method: .post,
                       requireAccessToken: true)
            
        }
    }
    
}
