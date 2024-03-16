//
//  CardConfigGateway.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 22/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import Combine
import Foundation

protocol CardConfigGatewayType {
    func getCardConfig(configCode:String, configVersion: String?) -> Observable<CardConfig>
    func getCardConfigs() -> Observable<[CardConfig]>
}


struct CardConfigGateway: CardConfigGatewayType {
    func getCardConfigs() -> Observable<[CardConfig]> {
        let input = API.GetCardConfigsList()
        return API.shared.getCardConfigsList(input: input)
    }
    
    func getCardConfig(configCode:String, configVersion: String?) -> Observable<CardConfig> {
        
        let input = API.GetCardConfigInput(configCode: configCode, configVersion: configVersion)
        return API.shared.getCardConfig(input: input)
    }
}

struct PreviewCardConfigGateway: CardConfigGatewayType {
    func getCardConfigs() -> Observable<[CardConfig]> {
        Future<[CardConfig], Error> { promise in
            
            promise(.success([CardConfig(configCode: "AA002")]))
        }
        .eraseToAnyPublisher()
    }
    
    func getCardConfig(configCode:String, configVersion: String?) -> Observable<CardConfig> {
        Future<CardConfig, Error> { promise in
            
            promise(.success(CardConfig(configCode: "AA002")))
        }
        .eraseToAnyPublisher()
    }
    
}

