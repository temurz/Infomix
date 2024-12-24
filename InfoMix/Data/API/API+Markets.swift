//
//  API+Markets.swift
//  InfoMix
//
//  Created by Temur A. Zaitov on 23/12/24.
//  Copyright © 2024 InfoMix. All rights reserved.
//

import Foundation
import Alamofire

extension API {
    func getMarketsList(_ input: GetMarketsList) -> Observable<[Market]>{
        return requestList(input)
    }

    final class GetMarketsList : APIInput{
        init(cityId: Int) {
            super.init(urlString: API.Urls.markets+"\(cityId)",
                       parameters: nil,
                       method: .get,
                       requireAccessToken: true)
        }
    }
}
