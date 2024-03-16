//
//  GettingLastEvents.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 21/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Combine

protocol GettingLastEvents {
    var eventGateway: EventGatewayType { get }
}

extension GettingLastEvents {
    func getLastEvents() -> Observable<[Event]> {
        eventGateway.getLastEvents()
    }
}
