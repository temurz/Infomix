//
//  NotificationsGateway.swift
//  CleanArchitecture
//
//  Created by Temur on 22/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Foundation

protocol NotificationsGatewayType {
    func getNotifications(dto: GetPageDto)-> Observable<PagingInfo<Notifications>>
}

struct NotificationsGateway : NotificationsGatewayType {
    
    
    func getNotifications(dto: GetPageDto) -> Observable<PagingInfo<Notifications>>{
        let input = API.GetNotificationsInput(dto: dto)
        
        return API.shared.getNotifications(input)
            .map{(output) -> [Notifications]? in
                return output
            }
            .replaceNil(with: [])
            .map { PagingInfo(page: dto.page, items: $0, hasMorePages: $0.count == dto.perPage)}
            .eraseToAnyPublisher()
    }
}
