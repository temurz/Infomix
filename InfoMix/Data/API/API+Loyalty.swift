//
//  API+Loyalty.swift
//  InfoMix
//
//  Created by Temur on 09/12/2024.
//  Copyright © 2024 InfoMix. All rights reserved.
//

import Foundation
extension API {
    func getLoyalty(_ input: APIGetLoyaltyInput) -> Observable<Loyalty> {
        request(input)
    }
    
    final class APIGetLoyaltyInput: APIInput {
        init() {
            super.init(urlString: API.Urls.getLoyalty, parameters: nil, method: .get, requireAccessToken: true)
        }
    }
    
}
