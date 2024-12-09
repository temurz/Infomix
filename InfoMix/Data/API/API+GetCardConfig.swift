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
        requestWithBase64(input)
    }
    
    final class GetCardConfigInput : APIInput{
        
        init(configCode: String, configVersion: String?){
            var params : Parameters = [:]
            if let configVersion = configVersion {
                params["configVersion"] = configVersion
            }
            params["configCode"] = configCode
            
            super.init(urlString: API.Urls.configs,
                       parameters: params,
                       method: .get,
                       requireAccessToken: true)
        }
    }
    
}
