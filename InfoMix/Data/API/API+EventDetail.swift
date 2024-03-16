//
//  API+EventContent.swift
//  CleanArchitecture
//
//  Created by Temur on 07/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Alamofire
import Combine

extension API {
    
    func getEventDetail(_ input: GetEventDetailInput) -> Observable<Event> {
        return request(input)
    }
    
    final class GetEventDetailInput: APIInput {
        init(eventId: Int32) {
            
        
            
            super.init(urlString: String.init(format: Urls.eventDetail, eventId),
                       parameters: nil,
                       method: .get,
                       requireAccessToken: true)
        }
    }
    
}

