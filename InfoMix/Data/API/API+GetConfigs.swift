//
//  API+GetConfigs.swift
//  InfoMix
//
//  Created by Temur on 29/03/22.
//  Copyright © 2022 InfoMix. All rights reserved.
//

import Foundation
import Alamofire

extension API {
    func getCardConfigsList(input: APIInput) ->Observable<[CardConfig]>{
        requestListWithBase64(input)
    }
    
    final class GetCardConfigsList : APIInput{
        init(){
//            let params : Parameters = [
//                "asString" : false
//            ]
            super.init(urlString: API.Urls.configs,
                       parameters:nil,
                       method: .get,
                       requireAccessToken: true)
        }
    }
}
