//
//  API+SendingSerialNumbers.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 24/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//
import Alamofire
import Combine

extension API {
    
    func sendSerialNumbers(_ input: SendingSerialNumbers) -> Observable<SerialCard> {
        return request(input)
    }
    
    final class SendingSerialNumbers: APIInput {
        init(serialCardId: Int, serialNumbers: String){
            let parameters: Parameters = [
                "serial_card_id": serialCardId,
                "serialNumbers": serialNumbers
            ]
            
            super.init(urlString: "\(NetworkManager.shared.baseUrl)/cards/add/part/serials",
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
