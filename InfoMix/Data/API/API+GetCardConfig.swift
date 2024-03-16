//
//  API+GetCardConfig.swift
//  InfoMix
//
//  Created by Temur on 06/04/22.
//  Copyright © 2022 InfoMix. All rights reserved.
//

import Foundation
import Alamofire

extension API{
    func getCardConfig(input: APIInput) -> Observable<CardConfig>{
        request(input)
    }
    
    final class GetCardConfigInput : APIInput{
        
        init(configCode: String, configVersion: String?){
            var params : Parameters = [:]
            if let configVersion = configVersion {
                params["configVersion"] = configVersion
            }
            super.init(urlString: API.Urls.configs+"\(configCode)",
                       parameters: params,
                       method: .get,
                       requireAccessToken: true)
        }
    }
    
}
