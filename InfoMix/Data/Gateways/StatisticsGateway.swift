//
//  StatisticsGateway.swift
//  InfoMix
//
//  Created by Temur on 09/12/2024.
//  Copyright © 2024 InfoMix. All rights reserved.
//

import Foundation
protocol StatisticsGatewayType {
    func getStatistics() -> Observable<Statistics>
}

struct StatisticsGateway: StatisticsGatewayType {
    func getStatistics() -> Observable<Statistics> {
        return API.shared.getStatistics()
    }
}
