//
//  API+SendingDone.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 24/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import Alamofire
import Combine

extension API {
    
    func done(_ input: SendingDone) -> Observable<Transaction> {
        return request(input)
    }
    
    final class SendingDone: APIInput {
        init(serialCardId: Int){
            let parameters: Parameters = [
                "serial_card_id": serialCardId
            ]
            super.init(urlString: "\(NetworkManager.shared.baseUrl)/cards/add/done",
                       parameters: parameters,
                       method: .post,
                       requireAccessToken: true)
            
            self.headers = [
                "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8"
            ]
            self.encoding = URLEncoding.httpBody
        }
    }
    
}

