//
//  API+GetOrders.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 12/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Alamofire
import Combine

extension API {
    
    func getOrders(_ input: GetOrderListApiInput) -> Observable<[Order]> {
        return requestList(input)
    }
    
    final class GetOrderListApiInput: APIInput {
        
        init(dto: GetPageDto, from:String?, to: String?, status: String?){
            var parameters: Parameters = [
                "page": dto.page,
                "rows": dto.perPage
                ]
            if let from = from {
                parameters["from"] = from
            }
            if let to = to {
                parameters["to"] = to
            }
            if let status = status {
                parameters["status"] = status
            }
                
            
            super.init(urlString: Urls.getOrders,
                       parameters: parameters,
                       method: .post,
                       requireAccessToken: true)
            
        }
    }
    
}
