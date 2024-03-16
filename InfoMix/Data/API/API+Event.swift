//
//  API+Event.swift
//  CleanArchitecture
//
//  Created by Temur on 18/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import Alamofire
import Combine

extension API {
    
    func getEventList(_ input: GetEventListInput) -> Observable<[Event]> {
        return requestList(input)
    }
    
    final class GetEventListInput: APIInput {
        init(dto: GetPageDto, typeId: Int?) {
            var params: Parameters = [
                "rows": dto.perPage,
                "page": dto.page
            ]
            if let typeId = typeId {
                params["typeId"] = typeId
            }
            super.init(urlString: API.Urls.events,
                       parameters: params,
                       method: .post,
                       requireAccessToken: true)
            
        }
    }
    
}
