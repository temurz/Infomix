//
//  CheckSerialNumberUseCase.swift
//  InfoMix
//
//  Created by Temur on 02/05/2025.
//  Copyright © 2025 InfoMix. All rights reserved.
//

protocol CheckSerialNumberUseCase {
    var checkSerialNumberGateway: CheckSerialNumberGatewayProtocol { get }
}

extension CheckSerialNumberUseCase {
    func checkSerialNumber(_ serialNumber: String) -> Observable<SerialNumberedProduct> {
        return checkSerialNumberGateway.checkSerialNumber(serialNumber)
    }
}
