//
//  HomeViewModal.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 12/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import Combine
import Alamofire
import Foundation
import SwiftUI

struct HomeViewModel {
    let homeNavigator: HomeNavigatorType
    let currentUserUseCase: CurrentUserUseCaseType
    let lastEventsUseCase: LastEventsUseCaseType
    let fcmTokenUseCase: FcmTokenUseCaseType
    let cardConfig: CardConfig

    private let loadLastEventsTrigger = PassthroughSubject<Void,Never>()
    private let sendFcmTokenTrigger = PassthroughSubject<String,Never>()
    
}

extension HomeViewModel: ViewModel {
    
    struct Input{
        let showLocalUsersTrigger: Driver<Void>
        let showTransactionHistoryTrigger: Driver<Void>
        let showExchangeTrigger: Driver<Void>
        let loadTrigger: Driver<Void>
        let reloadTrigger: Driver<Void>
        let showEventsTrigger: Driver<Void>
        let showMyCardsTrigger: Driver<Void>
        let countDownTrigger: Driver<Void>
        let selectEventTrigger: Driver<EventItemViewModel>
        let closeAdEventTrigger: Driver<Void>
        let sendFcmTokenTrigger: Driver<String>
    }

    final class Output: ObservableObject {
       
        @Published var certificate: CertificateItemViewModel = CertificateItemViewModel()
        @Published var lastEvents = [EventItemViewModel]()
        @Published var shownAdEvent = false
        @Published var adTimeRemaining: Int = 5
        @Published var adEvent: EventItemViewModel? = nil
        @Published var alert = AlertMessage()
        @Published var cardConfig: CardConfig
        
        init(cardConfig: CardConfig){
            self.cardConfig = cardConfig
        }
    
        
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output(cardConfig: self.cardConfig)
        
        let getItemInput = GetItemInput(loadTrigger: input.loadTrigger,
                                        reloadTrigger: input.reloadTrigger,
                                        getItem: currentUserUseCase.getCurrentUser)
        let (item, error, _, _) = getItem(input: getItemInput).destructured

        
        item
            .handleEvents(receiveOutput: {
                _ in
                loadLastEventsTrigger.send(())
            })
            .map{ CertificateItemViewModel.init(certificate: $0) }
            .assign(to: \.certificate, on: output)
            .store(in: cancelBag)
       
        
        error
            .receive(on: RunLoop.main)
            .map { AlertMessage(error: $0) }
            .assign(to: \.alert, on: output)
            .store(in: cancelBag)
        
        
        let getLastEventsInput = GetListInput(loadTrigger: self.loadLastEventsTrigger.asDriver(), reloadTrigger: Driver.empty(), getItems: lastEventsUseCase.getLastEvents)
        
        let (lastEvents, _, _, _) = getList(input: getLastEventsInput).destructured
        
        lastEvents.map{ $0.map(EventItemViewModel.init)}.handleEvents(receiveOutput: {
            list in
            if !output.shownAdEvent {
                output.adEvent = list.first(where: { it in
                    it.ads
                })
            }
        
        }).assign(to: \.lastEvents, on: output)
            .store(in: cancelBag)
        
        input.showTransactionHistoryTrigger
            .sink(receiveValue: {
                self.homeNavigator.showTransactionHistory()
            })
            .store(in: cancelBag)
        
        input.showExchangeTrigger
            .sink(receiveValue: {
                self.homeNavigator.showExchange()
            })
            .store(in: cancelBag)
        
        input.showEventsTrigger
            .sink { index in
                self.homeNavigator.showEvents()
            }.store(in: cancelBag)
        
        
        input.showLocalUsersTrigger
            .sink { index in
                self.homeNavigator.showLocalUsers(cardConfig: output.cardConfig)
            }.store(in: cancelBag)
        
        input.countDownTrigger.sink { () in
            output.adTimeRemaining -= 1
            
            if output.adTimeRemaining == 0 {
                output.shownAdEvent.toggle()
                output.adEvent = nil
            }
        }.store(in: cancelBag)
        
        input.selectEventTrigger.sink { item in
            homeNavigator.toEventDetail(event: item.event)
        }.store(in: cancelBag)
        
        input.showMyCardsTrigger.sink { index in
            self.homeNavigator.showCardsHistory()
        }.store(in: cancelBag)
        
        input.closeAdEventTrigger.sink { it in
            output.shownAdEvent.toggle()
            output.adEvent = nil
        }.store(in: cancelBag)
        
        let sendFcmTokenInput = GetItemInput(loadTrigger: input.sendFcmTokenTrigger, reloadTrigger: Driver.empty(), getItem: fcmTokenUseCase.sendFcmToken)
        
        let (fcmSuccess, _, _, _) = getItem(input: sendFcmTokenInput).destructured
        
        fcmSuccess.sink().store(in: cancelBag)
        
        
        return output
    }
}
