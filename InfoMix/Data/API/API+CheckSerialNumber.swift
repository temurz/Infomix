//
//  API+CheckSerialNumber.swift
//  InfoMix
//
//  Created by Temur on 02/05/2025.
//  Copyright © 2025 InfoMix. All rights reserved.
//

extension API {
    func checkSerialNumber(_ input: CheckBarcodeAPIInput) -> Observable<SerialNumberedProduct> {
        request(input)
    }

    final class CheckBarcodeAPIInput: APIInput {
        init(_ serialNumber: String) {
            let params = [
                "serialNumber": serialNumber
            ]
            super.init(urlString: API.Urls.checkSerialNumber, parameters: params, method: .get, requireAccessToken: true)
        }
    }
}
