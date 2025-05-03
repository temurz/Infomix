//
//  ScannerViewUseCase.swift
//  InfoMix
//
//  Created by Temur on 02/05/2025.
//  Copyright © 2025 InfoMix. All rights reserved.
//

protocol ScannerViewUseCaseType {
    func checkSerialNumber(_ serialNumber: String) -> Observable<SerialNumberedProduct>
}

struct ScannerViewUseCase: ScannerViewUseCaseType, CheckSerialNumberUseCase {
    var checkSerialNumberGateway: CheckSerialNumberGatewayProtocol
}
