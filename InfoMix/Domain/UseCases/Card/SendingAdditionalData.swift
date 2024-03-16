//
//  SendingAdditionalData.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 24/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//




import Combine
import Foundation

protocol SendingAdditionalData {
    var cardGateway: CardGatewayType { get }
}

extension SendingAdditionalData {
    func sendAdditionData(_ input: AdditionalDataInput) -> Observable<SerialCard> {
        cardGateway.sendAdditionData(serialCardId: input.serialCardId, installedDate: input.installedDate, phone: input.phone, latitude: input.latitude, longitude: input.longitude)
    }
}

