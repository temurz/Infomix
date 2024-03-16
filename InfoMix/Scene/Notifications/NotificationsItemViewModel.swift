//
//  NotificationsItemViewModel.swift
//  CleanArchitecture
//
//  Created by Temur on 22/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Foundation

struct NotificationsItemViewModel : Identifiable{
    let id : Int
    let notification : Notifications
    let title : String
    let content : String
    let createDate : Date?
    let objectId : Int
    
    init(notification : Notifications) {
        self.notification = notification
        self.title = notification.title ?? ""
        self.content = notification.content ?? ""
        self.createDate = notification.createDate
        self.id  = notification.id
        self.objectId = notification.objectId
    }
}
