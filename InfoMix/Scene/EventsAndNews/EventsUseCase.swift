//
//  EventsUseCase.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 13/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

protocol EventsUseCaseType {
    func getEvents(typeId: Optional<Int>, page: Int) -> Observable<PagingInfo<Event>>
}

struct EventsUseCase: EventsUseCaseType, GettingEvents {
    let eventGateway: EventGatewayType
    
    func getEvents(typeId: Optional<Int>, page: Int) -> Observable<PagingInfo<Event>> {
        let dto = GetPageDto(page: page, perPage: 10)
        return getEvents(dto: dto, typeId: typeId.wrapped)
    }
}
