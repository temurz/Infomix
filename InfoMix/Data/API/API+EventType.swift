//
//  API+EventType.swift
//  CleanArchitecture
//
//  Created by Temur on 22/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import Alamofire
import Combine

extension API {
    
    func getEventTypeList(_ input: GetEventTypeListInput) -> Observable<[EventType]> {
        return requestList(input)
    }
    
    final class GetEventTypeListInput: APIInput {
        init() {
            
            
            super.init(urlString: API.Urls.eventTypes,
                       parameters: nil,
                       method: .get,
                       requireAccessToken: true)
        }
    }
    
}
