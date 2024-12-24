//
//  SendImageValue.swift
//  InfoMix
//
//  Created by Temur A. Zaitov on 21/12/24.
//  Copyright © 2024 InfoMix. All rights reserved.
//

import Foundation

protocol SendingImageValue{
    var cardGateway : CardGatewayType { get }
}

extension SendingImageValue{
    func sendImageValue(input: ImageValueInput) -> Observable<SerialCard>{
        cardGateway.sendImageValue(inputData: input)
    }
}
