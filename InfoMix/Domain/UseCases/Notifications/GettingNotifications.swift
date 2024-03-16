//
//  GettingNotifications.swift
//  CleanArchitecture
//
//  Created by Temur on 22/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Foundation

protocol GettingNotifications {
    var notificationsGateway : NotificationsGateway { get }
}

extension GettingNotifications {
    func getNotifications(dto: GetPageDto) -> Observable<PagingInfo<Notifications>> {
        notificationsGateway.getNotifications(dto: dto)
    }
}
