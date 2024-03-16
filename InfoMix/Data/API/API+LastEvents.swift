//
//  API+LastEvents.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 21/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//


import Alamofire
import Combine

extension API {
    
    func getLastEventList(_ input: GetLastEventListApiInput) -> Observable<[Event]> {
        return requestList(input)
    }
    
    final class GetLastEventListApiInput: APIInput {
        init() {
            
            super.init(urlString: API.Urls.events,
                       parameters: [
                        "page": 1,
                        "rows": 4
                       ],
                       method: .post,
                       requireAccessToken: true)
            
        }
    }
    
}
