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
    func getMarkets(cityId: Int) -> Observable<[Market]>
    func sendOnlineApplication(dto: OnlineApplicationDto) -> Observable<Bool>
}

struct OnlineApplicationUseCase: OnlineApplicationUseCaseType, GettingCities, GettingCardConfig, GettingMarket, SendingOnlineApplication {
    var gateway: MarketGateway
    
    var onlineApplicationGateway: any OnlineApplicationGatewayType
    
    func getConfigs() -> Observable<[CardConfig]> {
        getCardConfigs()
    }
    
    var cardConfigGateway: CardConfigGatewayType
    
    var cityGateway: CityGateway
    
    
}
