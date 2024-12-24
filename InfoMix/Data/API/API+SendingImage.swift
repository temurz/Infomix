//
//  API+SendingImageValue.swift
//  Viessmann
//
//  Created by Temur on 11/04/22.
//  Copyright © 2022 Viessmann. All rights reserved.
//

import Foundation
import Alamofire

extension API {

    func sendImageValue(input: APIUploadInputBase) -> Observable<SerialCard> {
        request(input)
    }

    final class SendingImageValueInput : APIUploadInputBase{
        init(imageValueInput: ImageValueInput){

            super.init(data: [APIUploadData(data: imageValueInput.data, name: "image", fileName: "photo.jpg", mimeType: "image/jpeg")], urlString: "\(NetworkManager.shared.baseUrl)/cards/add/part/image",
                       parameters: ["serial_card_id": imageValueInput.serialCardId, "imageName": imageValueInput.fileName],
                       method: .post,
                       requireAccessToken: true)

            self.headers = [
                "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
                "Authorization": "Bearer " + (UserDefaults.standard.string(forKey: "token") ?? "")
            ]
            self.encoding = URLEncoding.httpBody
        }
    }
}
