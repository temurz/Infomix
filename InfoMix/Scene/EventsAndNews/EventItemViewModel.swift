//
//  EventItemViewModel.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 13/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import Foundation

struct EventItemViewModel {
    let event: Event
    let title: String
    let shortDescription : String
    let content : String
    let imageUrl : String
    let endEventDate : Date?
    let createDate : Date?
    let type : EventType
    let ads : Bool

    
    init(event: Event) {
        self.event = event
        self.title = event.title ?? ""
        self.shortDescription = event.shortDescription ?? ""
        self.content = event.content ?? ""
        self.imageUrl = event.imageUrl ?? ""
        self.endEventDate = event.endEventDate
        self.createDate = event.createDate
        self.type = event.type ?? EventType(id: 1, name: "")
        self.ads = event.ads ?? false

    }
}
