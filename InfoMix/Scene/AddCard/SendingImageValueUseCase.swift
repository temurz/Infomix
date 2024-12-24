//
//  SendingImageValueUseCase.swift
//  Viessmann
//
//  Created by Temur on 11/04/22.
//  Copyright © 2022 Viessmann. All rights reserved.
//

import Foundation

protocol SendingImageValueUseCaseType{
    func sendImageValue(input: ImageValueInput) -> Observable<SerialCard>
}

struct SendingImageValueUseCase : SendingImageValueUseCaseType, SendingImageValue {

    let cardGateway: CardGatewayType

}

struct ImageValueInput{
    var serialCardId: Int
    var data : Data
    var fileName : String
}
