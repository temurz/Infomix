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
    func sendImageValue(input: ImageValueInput) -> Observable<SerialCard>
}

struct SendingAdditionalDataUseCase: SendingAdditionalDataUseCaseType, SendingAdditionalData, SendingImageValue {
    let cardGateway: CardGatewayType

}


struct AdditionalDataInput{
    let serialCardId: Int
    let installedDate: Date
    let data: [AddCardStepItem]
    let latitude: Double?
    let longitude: Double?
}
