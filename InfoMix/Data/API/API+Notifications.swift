//
//  API+Notifications.swift
//  CleanArchitecture
//
//  Created by Temur on 22/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Alamofire



extension API {
    
    func getNotifications(_ input: GetNotificationsInput) -> Observable<[Notifications]>{
        return requestList(input)
    }
    
    final class GetNotificationsInput : APIInput {
        init(dto: GetPageDto) {
            let params : Parameters = [
                "rows" : dto.perPage,
                "page" : dto.page
            ]
            super.init(urlString: API.Urls.getNotifications,
                       parameters: params,
                       method: .post,
                       requireAccessToken: true)
        }
    }
}
