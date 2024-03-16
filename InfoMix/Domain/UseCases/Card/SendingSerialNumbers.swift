//
//  SendingSerialNumbers.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 24/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//




import Combine

protocol SendingSerialNumbers {
    var cardGateway: CardGatewayType { get }
}

extension SendingSerialNumbers {
    func sendSerialNumbers(_ input: SerialNumbersInput) -> Observable<SerialCard> {
        cardGateway.sendSerialNumbers(serialCardId: input.serialCardId, serialNumbers: input.serialNumbers)
    }
}

