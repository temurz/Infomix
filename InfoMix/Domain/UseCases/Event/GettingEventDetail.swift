//
//  GettingEventContent.swift
//  CleanArchitecture
//
//  Created by Temur on 07/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Combine

protocol GettingEventDetail {
    var eventGateway: EventGatewayType { get }
}

extension GettingEventTypes {
    func getEventDetail(id: Int32) -> Observable<Event> {
        eventGateway.getEventDetail(id: id)
    }
}
