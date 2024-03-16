//
//  API+SendingFcmToken.swift
//  InfoMix
//
//  Created by Temur on 24/02/22.
//  Copyright © 2022 InfoMix. All rights reserved.
//

import Foundation
import Alamofire

extension API{
    
    func sendFcmToken(_ input: SendFcmTokenAPIInput) -> Observable<Bool>{
        return success(input)
    }
    
    final class SendFcmTokenAPIInput: APIInput{
        
        init(token: String){
            
            let parameters: Parameters=[
                "fcmId" : token
            ]
            
            super.init(
                urlString: API.Urls.sendFcmToken,
                parameters: parameters,
                method: .get,
                requireAccessToken: false)
        }
        
        
    }
}
