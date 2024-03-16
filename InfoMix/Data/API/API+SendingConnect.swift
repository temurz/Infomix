//
//  API+SendingConnect.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 24/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import Alamofire
import Combine

extension API {
    
    func connect(_ input: SendingConnectInput) -> Observable<Int64> {
        return requestPrimitive(input)
    }
    
    final class SendingConnectInput: APIInput {
        init(){
            
            super.init(urlString: "\(NetworkManager.shared.baseUrl)/cards/connect",
                       parameters: nil,
                       method: .get,
                       requireAccessToken: true)
            
        }
    }
    
}
