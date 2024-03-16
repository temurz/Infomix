//
//  OnlineApplicationUseCase.swift
//  InfoMix
//
//  Created by Temur on 07/03/22.
//  Copyright © 2022 InfoMix. All rights reserved.
//

import Foundation

protocol OnlineApplicationUseCaseType {
    func getCities() -> Observable<[City]>
    func getConfigs() -> Observable<[CardConfig]>
}

struct OnlineApplicationUseCase: OnlineApplicationUseCaseType, GettingCities, GettingCardConfig{
    func getConfigs() -> Observable<[CardConfig]> {
        getCardConfigs()
    }
    
    var cardConfigGateway: CardConfigGatewayType
    
    var cityGateway: CityGateway
    
    
}
