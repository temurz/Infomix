//
//  API+GetOrderStatusList.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 12/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Alamofire
import Combine

extension API {
    
    func getOrderStatusList(_ input: GetOrderStatusListApiInput) -> Observable<[OrderStatus]> {
        return requestList(input)
    }
    
    final class GetOrderStatusListApiInput: APIInput {
        
        init(){
            super.init(urlString: Urls.getOrderStatuses,
                       parameters: nil,
                       method: .get,
                       requireAccessToken: true)
            
        }
    }
    
}
