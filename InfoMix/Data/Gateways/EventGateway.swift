//
//  EventGateway.swift
//  CleanArchitecture
//
//  Created by Temur on 18/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import Combine
import Foundation

protocol EventGatewayType {
    func getEvents(dto: GetPageDto, typeId: Int?) -> Observable<PagingInfo<Event>>
    func getEventsTypes() -> Observable<[EventType]>
    func getEventDetail(id: Int32?) -> Observable<Event>
    func getLastEvents() -> Observable<[Event]>
}

struct EventGateway: EventGatewayType {
    func getLastEvents() -> Observable<[Event]> {
        let input = API.GetLastEventListApiInput()
        
        return API.shared.getLastEventList(input)
            .eraseToAnyPublisher()
    }
    
    
    func getEventDetail(id: Int32?) -> Observable<Event> {
        let input = API.GetEventDetailInput(eventId: id ?? 0)
        
        return API.shared.getEventDetail(input)
            .eraseToAnyPublisher()
    }
    
    
    
    func getEventsTypes() -> Observable<[EventType]> {
        let input = API.GetEventTypeListInput()
        
        return API.shared.getEventTypeList(input)
            .map { (output) -> [EventType]? in
                return output
            }
            .replaceNil(with: [])
            
            .eraseToAnyPublisher()
    }
    
    func getEvents(dto: GetPageDto, typeId: Int?) -> Observable<PagingInfo<Event>> {
        let input = API.GetEventListInput(dto: dto, typeId: typeId)
        
        return API.shared.getEventList(input)
            .map { (output) -> [Event]? in
                return output
            }
            .replaceNil(with: [])
            .map { PagingInfo(page: dto.page, items: $0) }
            .eraseToAnyPublisher()
    }
}

struct PreviewEventGateway: EventGatewayType {
    func getLastEvents() -> Observable<[Event]> {
        Future<[Event], Error> { promise in
            let events = [
                Event(id: 0,
                      title: "SwiftUI",
                      shortDescription: "SwiftUI Framework",
                      content: "",
                      imageUrl: "10",
                      endEventDate: Date(),
                      createDate: Date(),
                      type: EventType(id: 0, name: "SwiftUI"),
                      ads: false
                      )
            ]
            
            promise(.success(events))
        }
        .eraseToAnyPublisher()
    }
    
    func getEventDetail(id: Int32?) -> Observable<Event> {
        Future<Event,Error> {
            promise in
            let event =
                Event(id: 0,
                      title: "SwiftUI",
                      shortDescription: "SwiftUI Framework",
                      content: "",
                      imageUrl: "10",
                      endEventDate: Date(),
                      createDate: Date(),
                      type: EventType(id: 0, name: "SwiftUI"),
                      ads: false
                      )
            
            
            promise(.success(event))
        }
        .eraseToAnyPublisher()
    }
    
    func getEventsTypes() -> Observable<[EventType]> {
        Future<Array<EventType>, Error> { promise in
            let eventTypes = [
                EventType(id: 1, name: "")
            ]
            
            promise(.success(eventTypes))
        }
        .eraseToAnyPublisher()
    }
    
    func getEvents(dto: GetPageDto, typeId: Int?) -> Observable<PagingInfo<Event>> {
        Future<PagingInfo<Event>, Error> { promise in
            let events = [
                Event(id: 0,
                      title: "SwiftUI",
                      shortDescription: "SwiftUI Framework",
                      content: "",
                      imageUrl: "10",
                      endEventDate: Date(),
                      createDate: Date(),
                      type: EventType(id: 0, name: "SwiftUI"),
                      ads: false
                      )
            ]
            
            let page = PagingInfo<Event>(page: 1, items: events)
            promise(.success(page))
        }
        .eraseToAnyPublisher()
    }
}

