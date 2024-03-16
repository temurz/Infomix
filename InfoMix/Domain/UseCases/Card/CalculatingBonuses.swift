//
//  SendingDone.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 24/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//


import Combine
import Foundation

protocol CalculatingBonuses {
    var cardGateway: CardGatewayType { get }
}

extension CalculatingBonuses {
    func calculateBonuses(_ input: CalculateBonusesInput) -> Observable<Transaction> {
        cardGateway.calculateBonuses(serialCardId: input.serialCardId)
    }
}

