//
//  API+Resume.swift
//  InfoMix
//
//  Created by Temur on 07/04/22.
//  Copyright © 2022 InfoMix. All rights reserved.
//

import Foundation
import Alamofire
import Combine

extension API{
    func sendResume(_ input: SendingResumeInput) -> Observable<Bool> {
        return success(input)
    }

    final class SendingResumeInput: APIUploadInputBase {
        init(dto: OnlineApplicationDto){

            var params : [String: Encodable] = [:]

            if let firstName = dto.name {
                params["firstName"] = firstName
            }

            if let lastName = dto.surname {
                params["lastName"] = lastName
            }

            if let fathersName = dto.fathersname {
                params["middleName"] = fathersName
            }

            if let phone = dto.phoneNumber {
                params["phone"] = phone
            }

            if let cityId = dto.cityId {
                params["cityId"] = cityId
            }

            if let birthday = dto.age {
                params["birthdayStr"] = birthday.toApiFormat()
            }

            if let aboutMe = dto.aboutMe {
                params["aboutMe"] = aboutMe
            }

            if let marketId = dto.marketId {
                params["marketId"] = marketId
            }

            if let shopNumber = dto.shopNumber {
                params["shopNumber"] = shopNumber
            }

            var photoData: [APIUploadData] = []
            if let passportPhoto  = dto.photoIdCard  {
                if !passportPhoto.isEmpty {
                    photoData.append(APIUploadData(data: passportPhoto, name: "passportPhoto", fileName: "\(UUID().uuidString).jpeg", mimeType: "image/jpeg"))
                }

            }

            if let selfiePhoto  = dto.photoSelfie {
                if !selfiePhoto.isEmpty {
                    photoData.append(APIUploadData(data: selfiePhoto, name: "selfiePhoto", fileName: "\(UUID().uuidString).jpeg", mimeType: "image/jpeg"))
                }

            }

            super.init(data: photoData,
                       urlString: API.Urls.onlineApplication,
                       parameters: params, method: .post,
                       requireAccessToken: true)



            self.headers = [
                "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8"
            ]
            self.encoding = URLEncoding.httpBody
        }
    }
}
