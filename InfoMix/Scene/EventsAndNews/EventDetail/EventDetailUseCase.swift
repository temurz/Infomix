//
//  EventDetailUseCase.swift
//  CleanArchitecture
//
//  Created by Temur on 18/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import Foundation

protocol EventDetailUseCaseType {
    func getEventDetail(id: Int32)->Observable<Event>
}

struct EventDetailUseCase: EventDetailUseCaseType {
    let eventGateway: EventGatewayType
    
    func getEventDetail(id: Int32) -> Observable<Event> {
        return eventGateway.getEventDetail(id: id)
    }
}
