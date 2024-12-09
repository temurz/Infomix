//
//  API+Statistics.swift
//  InfoMix
//
//  Created by Temur on 09/12/2024.
//  Copyright © 2024 InfoMix. All rights reserved.
//

import Foundation
extension API {
    func getStatistics() -> Observable<Statistics> {
        request(GetStatisticsAPIInput())
    }
    
    final class GetStatisticsAPIInput: APIInput {
        init() {
            super.init(urlString: API.Urls.statistics, parameters: nil, method: .get, requireAccessToken: true)
        }
    }
}
