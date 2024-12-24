//
//  SendingSerialNumbersUseCase.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 24/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//


protocol SendingSerialNumbersUseCaseType {
    func sendSerialNumbers(_ input: SerialNumbersInput) -> Observable<SerialCard>
}

struct SendingSerialNumbersUseCase: SendingSerialNumbersUseCaseType, SendingSerialNumbers {
    let cardGateway: CardGatewayType
  
}

struct SerialNumbersInput {
    let serialCardId: Int
    let serialNumbers: [SerialNumberInput]
}
