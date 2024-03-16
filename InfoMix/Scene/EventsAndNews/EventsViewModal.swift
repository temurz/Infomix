//
//  EventsViewModal.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 13/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import Combine
import UIKit

struct EventsViewModel {
    let navigator: EventsNavigatorType
    let useCase: EventsUseCaseType
    let typesUseCase: EventTypeUseCaseType
    let loadEventsTrigger = PassthroughSubject<Optional<Int>,Never>()
}

// MARK: - ViewModelType
extension EventsViewModel: ViewModel {
    struct Input {
        let loadEventTypesTrigger: Driver<Void>
        let loadEventsTrigger: Driver<Optional<Int>>
        let reloadEventsTrigger: Driver<Optional<Int>>
        let loadMoreEventsTrigger: Driver<Optional<Int>>
        let selectEventTrigger: Driver<IndexPath>
        let selectEventTypeTrigger: Driver<IndexPath>
    }
    
    final class Output: ObservableObject {
        @Published var events = [EventItemViewModel]()
        @Published var isLoading = false
        @Published var isReloading = false
        @Published var isLoadingMore = false
        @Published var alert = AlertMessage()
        @Published var isEmpty = false
        @Published var types = [EventType]()
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        
        let getListInput = GetListInput(loadTrigger: input.loadEventTypesTrigger, reloadTrigger: Driver.empty(), getItems: typesUseCase.getEventTypes)
        
        let (types, _, _, _) = getList(input: getListInput).destructured
        
        types.handleEvents(receiveOutput: {
            it in
            output.types = it
            self.loadEventsTrigger.send(nil)
        }).sink().store(in: cancelBag)
        
        input.loadEventsTrigger.sink { it in
            self.loadEventsTrigger.send(it)
        }.store(in: cancelBag)
        
        input.selectEventTypeTrigger.sink { selected in
            if selected.row >= 0{
                self.loadEventsTrigger.send(selected.row)
            }else{
                self.loadEventsTrigger.send(nil)
            }
           
        }.store(in: cancelBag)
        
        let getPageInput = GetPageInput(loadTrigger: self.loadEventsTrigger.asDriver(),
                                        reloadTrigger: input.reloadEventsTrigger,
                                        loadMoreTrigger: input.loadMoreEventsTrigger,
                                        getItems: useCase.getEvents)
        
        let (page, error, isLoading, isReloading, isLoadingMore) = getPage(input: getPageInput).destructured

        page
            .map { $0.items.map(EventItemViewModel.init) }
            .assign(to: \.events, on: output)
            .store(in: cancelBag)
        
        error
            .receive(on: RunLoop.main)
            .map { AlertMessage(error: $0) }
            .assign(to: \.alert, on: output)
            .store(in: cancelBag)
        
        isLoading
            .assign(to: \.isLoading, on: output)
            .store(in: cancelBag)
        
        isReloading
            .assign(to: \.isReloading, on: output)
            .store(in: cancelBag)
        
        isLoadingMore
            .assign(to: \.isLoadingMore, on: output)
            .store(in: cancelBag)
        
        input.selectEventTrigger
            .sink { index in
                let event = output.events[index.row].event
                
                navigator.toEventDetail(event: event)
                
            }.store(in: cancelBag)
        
        return output
    }
}
