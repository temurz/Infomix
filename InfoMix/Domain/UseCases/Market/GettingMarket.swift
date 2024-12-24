//
//  GettingMarket.swift
//  InfoMix
//
//  Created by Temur A. Zaitov on 23/12/24.
//  Copyright © 2024 InfoMix. All rights reserved.
//

import Foundation

protocol GettingMarket{
    var gateway: MarketGateway { get }
}

extension GettingMarket{
    func getMarkets(cityId: Int) -> Observable<[Market]> {
        gateway.getMarkets(cityId: cityId)
    }
}
