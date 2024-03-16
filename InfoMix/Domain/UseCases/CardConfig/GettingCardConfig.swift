//
//  GettingCardConfig.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 22/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import Combine

protocol GettingCardConfig {
    var cardConfigGateway: CardConfigGatewayType { get }
}

extension GettingCardConfig {
    func getCardConfig(input: CardConfigInput) -> Observable<CardConfig> {
        cardConfigGateway.getCardConfig(configCode: input.configCode, configVersion: input.configVersion)
    }
    func getCardConfigs() -> Observable<[CardConfig]>{
        cardConfigGateway.getCardConfigs()
    }
}

