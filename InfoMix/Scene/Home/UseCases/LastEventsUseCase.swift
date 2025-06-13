//
//  LastEventsUseCase.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 21/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Foundation

protocol LastEventsUseCaseType {
    func getLastEvents() -> Observable<[Event]>
}

struct LastEventsUseCase: LastEventsUseCaseType, GettingLastEvents {
    let eventGateway: EventGatewayType
  
}

