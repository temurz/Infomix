//
//  API+SendingAdditionalData.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 24/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//
import Alamofire
import Combine
import Foundation

extension API {
    
    func sendAddtionalData(_ input: SendingAdditionalData) -> Observable<SerialCard> {
        return request(input)
    }
    
    final class SendingAdditionalData: APIInput {
        init(serialCardId: Int, phone: String?, installedDate: Date, longitude: Double?, latitude: Double?){
            var parameters: Parameters = [
                "serial_card_id": serialCardId,
                "installedDate": installedDate.toApiFormat()
            ]
            if let phone = phone{
                parameters["phone"] = phone
            }
            if let longitude = longitude {
                parameters["longitude"] = longitude
            } else {
                parameters["longitude"] = 69.2767137
            }
            if let latitude = latitude {
                parameters["latitude"] = latitude
            } else {
                    parameters["latitude"] = 41.3090463
            }
            super.init(urlString: "\(NetworkManager.shared.baseUrl)/cards/add/part/data",
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

