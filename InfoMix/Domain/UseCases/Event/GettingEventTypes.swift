//
//  GettingEventType.swift
//  CleanArchitecture
//
//  Created by Temur on 22/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//
import Combine

protocol GettingEventTypes {
    var eventGateway: EventGatewayType { get }
}

extension GettingEventTypes {
    func getEventsTypes() -> Observable<[EventType]> {
        eventGateway.getEventsTypes()
    }
}

