//
//  GetLoyaltyViewUseCase.swift
//  InfoMix
//
//  Created by Temur on 09/12/2024.
//  Copyright © 2024 InfoMix. All rights reserved.
//

import Foundation
protocol GetLoyaltyViewUseCaseType {
    func getLoyalty() -> Observable<Loyalty>
}

struct GetLoyaltyViewUseCase: GetLoyaltyViewUseCaseType, GetLoyaltyDomainUseCase {
    var gateway: LoyaltyGatewayType
}
