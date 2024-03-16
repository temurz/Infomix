//
//  EventTypeUseCase.swift
//  CleanArchitecture
//
//  Created by Temur on 22/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

protocol EventTypeUseCaseType {
    func getEventTypes() -> Observable<[EventType]>
}

struct EventTypeUseCase: EventTypeUseCaseType, GettingEventTypes {
    
    let eventGateway: EventGatewayType
    
    func getEventTypes() -> Observable<[EventType]> {
        
        return getEventsTypes()
    }
}


