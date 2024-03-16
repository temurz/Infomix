//
//  GetCardConfigUseCase.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 22/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

protocol GetCardConfigUseCaseType {
    func getCardConfig(input: CardConfigInput)->Observable<CardConfig>
}

struct GetCardConfigUseCase: GetCardConfigUseCaseType, GettingCardConfig {
    let cardConfigGateway: CardConfigGatewayType
    
}

struct CardConfigInput{
    var configCode : String
    var configVersion : String?
}
