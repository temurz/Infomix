//
//  GettingEvents.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 13/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import Combine

protocol GettingEvents {
    var eventGateway: EventGatewayType { get }
}

extension GettingEvents {
    func getEvents(dto: GetPageDto, typeId: Int?) -> Observable<PagingInfo<Event>> {
        eventGateway.getEvents(dto: dto, typeId: typeId)
    }
}
