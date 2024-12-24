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
        init(serialCardId: Int, data: [AddCardStepItem], installedDate: Date, longitude: Double?, latitude: Double?){
            var parameters: Parameters = [
                "serial_card_id": serialCardId,
                "installedDate": installedDate.toApiFormat()
            ]

            if(!data.isEmpty){
                data.filter{
                    !$0.valueString.isEmpty && $0.remoteName != nil
                }.forEach { item in
                    parameters[item.remoteName!] = item.valueString
                }
            }
            if let longitude = longitude {
                parameters["longitude"] = longitude
            }

            if let latitude = latitude {
                parameters["latitude"] = latitude
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
