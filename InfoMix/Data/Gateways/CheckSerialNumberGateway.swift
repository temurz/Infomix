//
//  CheckSerialNumberGateway.swift
//  InfoMix
//
//  Created by Temur on 02/05/2025.
//  Copyright © 2025 InfoMix. All rights reserved.
//

protocol CheckSerialNumberGatewayProtocol {
    func checkSerialNumber(_ serialNumber: String) -> Observable<SerialNumberedProduct>
}

struct CheckSerialNumberGateway: CheckSerialNumberGatewayProtocol {
    func checkSerialNumber(_ serialNumber: String) -> Observable<SerialNumberedProduct> {
        API.shared.checkSerialNumber(API.CheckBarcodeAPIInput(serialNumber))
            .eraseToAnyPublisher()
    }
}

struct SerialNumberedProduct: Decodable {
    let id: Int?
    let createDate: Int?
    let serialNumber: String?
    let modelId: Int?
    let modelVariantId: Int?
    let modelName: String?
    let componentsHTML: String?
    let accessible: Bool?
    let onStopList: Bool?
    let registered: Bool?
}
