//
//  MarketGateway.swift
//  InfoMix
//
//  Created by Temur A. Zaitov on 23/12/24.
//  Copyright © 2024 InfoMix. All rights reserved.
//

protocol MarketGatewayType{
    func getMarkets(cityId: Int) -> Observable<[Market]>
}

struct MarketGateway : MarketGatewayType{
    func getMarkets(cityId: Int) -> Observable<[Market]> {
        let input = API.GetMarketsList(cityId: cityId)
        return API.shared.getMarketsList(input)
            .map { (output) -> [Market]? in
                return output
            }
            .replaceNil(with: [])
            .eraseToAnyPublisher()
    }
}
