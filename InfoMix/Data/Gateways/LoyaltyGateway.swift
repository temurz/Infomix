//
//  LoyaltyGateway.swift
//  InfoMix
//
//  Created by Temur on 09/12/2024.
//  Copyright © 2024 InfoMix. All rights reserved.
//

import Foundation
protocol LoyaltyGatewayType {
    func getLoyalty() -> Observable<Loyalty>
}

struct LoyaltyGateway: LoyaltyGatewayType {
    func getLoyalty() -> Observable<Loyalty> {
        return API.shared.getLoyalty(API.APIGetLoyaltyInput())
    }
}
