//
//  GetStatisticsDomainUseCase.swift
//  InfoMix
//
//  Created by Temur on 09/12/2024.
//  Copyright © 2024 InfoMix. All rights reserved.
//

import Foundation
protocol GetStatisticsDomainUseCase {
    var gateway: StatisticsGatewayType { get }
}

extension GetStatisticsDomainUseCase {
    func getStatistics() -> Observable<Statistics> {
        return gateway.getStatistics()
    }
}
