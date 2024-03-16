//
//  NotificationsUseCase.swift
//  CleanArchitecture
//
//  Created by Temur on 22/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Foundation

protocol NotificationsUseCaseType {
    func getNotifications(page: Int) -> Observable<PagingInfo<Notifications>>
}

struct NotificationsUseCase : NotificationsUseCaseType, GettingNotifications {
    var notificationsGateway: NotificationsGateway
    
    func getNotifications(page: Int) -> Observable<PagingInfo<Notifications>> {
        let dto = GetPageDto(page: page, perPage: 10)
        return getNotifications(dto: dto)
    }
    
    
}
