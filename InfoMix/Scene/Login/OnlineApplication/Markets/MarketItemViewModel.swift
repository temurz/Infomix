//
//  MarketItemViewModel.swift
//  InfoMix
//
//  Created by Temur A. Zaitov on 23/12/24.
//  Copyright © 2024 InfoMix. All rights reserved.
//

import Foundation

struct MarketItemViewModel : Identifiable{
    var id : Int
    var name: String?

    init(market: Market){
        self.id  = market.id
        self.name = market.name
    }
}
