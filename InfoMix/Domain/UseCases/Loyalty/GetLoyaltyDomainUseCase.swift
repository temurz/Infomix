//
//  GetLoyaltyDomainUseCase.swift
//  InfoMix
//
//  Created by Temur on 09/12/2024.
//  Copyright © 2024 InfoMix. All rights reserved.
//

import Foundation
protocol GetLoyaltyDomainUseCase {
    var gateway: LoyaltyGatewayType { get }
}

extension GetLoyaltyDomainUseCase {
    func getLoyalty() -> Observable<Loyalty> {
        return gateway.getLoyalty()
    }
}
