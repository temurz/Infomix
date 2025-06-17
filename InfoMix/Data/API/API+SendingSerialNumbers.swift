//
//  API+SendingSerialNumbers.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 24/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//
import Alamofire
import Combine
import Foundation

extension API {
    
    func sendSerialNumbers(_ input: SendingSerialNumbers) -> Observable<SerialCard> {
        return request(input)
    }
    
    final class SendingSerialNumbers: APIInput {
        init(serialCardId: Int, serialNumbers: [SerialNumberInput]){
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let json = try? encoder.encode(serialNumbers)
            let string = String(data: json ?? Data(), encoding: .utf8)
            
            let parameters: Parameters = [
                "serialCardId": serialCardId,
                "serialNumbers": serialNumbers.map { [
                    "serialNumber": $0.serialNumber,
                    "input": $0.input
                ]
                }
            ]
            
            super.init(urlString: "\(NetworkManager.shared.baseUrl)/cards/add/part/serials",
                       parameters: parameters,
                       method: .post,
                       requireAccessToken: true,
                       encoding: JSONEncoding.default)

//            self.headers = [
//                "Content-Type": "application/json; charset=UTF-8"
//            ]
//            self.encoding = URLEncoding.httpBody
        }
    }
    
}

struct SerialNumberInput: Codable {
    var serialNumber: String
//    let serialNumberId: Int
    var input: String = "Scanner"
}
