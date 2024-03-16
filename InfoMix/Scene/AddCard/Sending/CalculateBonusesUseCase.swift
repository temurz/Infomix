//
//  SendingDoneUseCase.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 24/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import Foundation


protocol CalculateBonusesUseCaseType {
    func calculateBonuses(_ input: CalculateBonusesInput) -> Observable<Transaction>
}

struct CalculateBonusesUseCase: CalculateBonusesUseCaseType, CalculatingBonuses {
    let cardGateway: CardGatewayType
  
}

struct CalculateBonusesInput {
    let serialCardId: Int
}

