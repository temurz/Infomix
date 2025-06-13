//
//  GetStatisticsViewUseCase.swift
//  InfoMix
//
//  Created by Temur on 09/12/2024.
//  Copyright © 2024 InfoMix. All rights reserved.
//

import Foundation
protocol GetStatisticsViewUseCaseType {
    func getStatistics() -> Observable<Statistics>
}

struct GetStatisticsViewUseCase: GetStatisticsViewUseCaseType, GetStatisticsDomainUseCase {
    
    var gateway: StatisticsGatewayType
}
