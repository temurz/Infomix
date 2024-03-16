//
//  SendingAdditionalDataUseCase.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 24/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import Foundation


protocol SendingAdditionalDataUseCaseType {
    func sendAdditionData(_ input: AdditionalDataInput) -> Observable<SerialCard>
}

struct SendingAdditionalDataUseCase: SendingAdditionalDataUseCaseType, SendingAdditionalData {
    let cardGateway: CardGatewayType
  
}


struct AdditionalDataInput{
    let serialCardId: Int
    let installedDate: Date
    let phone: String?
    let latitude: Double?
    let longitude: Double?
}
