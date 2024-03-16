//
//  EventDetailViewModel.swift
//  CleanArchitecture
//
//  Created by Temur on 18/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import Foundation

struct EventDetailViewModel {
    let navigator: EventDetailNavigatorType
    let useCase: EventDetailUseCaseType
    let event: Event
}

// MARK: - ViewModelType
extension EventDetailViewModel: ViewModel {
    struct Input {
        let loadTrigger: Driver<Int32>
    }
    
    final class Output: ObservableObject {
        @Published var title = ""
        @Published var shortDescription = ""
        @Published var content = ""
        @Published var imageUrl = "x"
        @Published var endEventDate = Date()
        @Published var createEventDate = Date()
        @Published var type = EventType(id: 0, name: "")
        @Published var ads = false
        @Published var event: Event
        @Published var isLoading = false
        @Published var alert = AlertMessage()
        
        init(event: Event){
            self.event = event
        }
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
       
        
        let output = Output(event: self.event)
        
        let getItemInput = GetItemInput(loadTrigger: input.loadTrigger, reloadTrigger: Driver.empty(), getItem: self.useCase.getEventDetail)
        
        let (event, error, isLoading, _) = getItem(input: getItemInput).destructured
        
        event.assign(to: \.event, on: output)
            .store(in: cancelBag)
        
        error
            .receive(on: RunLoop.main)
            .map { AlertMessage(error: $0) }
            .assign(to: \.alert, on: output)
            .store(in: cancelBag)
        
        isLoading.assign(to: \.isLoading, on: output)
            .store(in: cancelBag)
        
        
        return output
    }
}
