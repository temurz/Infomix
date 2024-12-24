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
import Localize_Swift
struct HomeViewModel {
    let homeNavigator: HomeNavigatorType
    let currentUserUseCase: CurrentUserUseCaseType
    let lastEventsUseCase: LastEventsUseCaseType
    let fcmTokenUseCase: FcmTokenUseCaseType
    let getStatisticsUseCase: GetStatisticsViewUseCaseType
    let getLoyaltyUseCase: GetLoyaltyViewUseCaseType
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
        let getLoyaltyTrigger: Driver<Void>
        let getStatisticsTrigger: Driver<Void>
        let showAddCardTrigger: Driver<Void>
        let showShoppingViewTrigger: Driver<Void>
        let showNotificationsTrigger: Driver<Void>
    }

    final class Output: ObservableObject {
       
        @Published var certificate: CertificateItemViewModel = CertificateItemViewModel()
        @Published var lastEvents = [EventItemViewModel]()
        @Published var shownAdEvent = false
        @Published var adTimeRemaining: Int = 5
        @Published var adEvent: EventItemViewModel? = nil
        @Published var alert = AlertMessage()
        @Published var cardConfig: CardConfig
        @Published var loyalty: Loyalty?
        @Published var statistics: Statistics?
        @Published var items = [MainCellModel]()
        
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
        
        input.getLoyaltyTrigger
            .sink {
                getLoyaltyUseCase.getLoyalty()
                    .asDriver()
                    .sink { it in
                        output.loyalty = it
                        output.certificate.loyalty = it
                    }
                    .store(in: cancelBag)
            }
            .store(in: cancelBag)
        
        input.getStatisticsTrigger
            .sink {
                getStatisticsUseCase.getStatistics()
                    .asDriver()
                    .sink { it in
                        output.statistics = it
                        output.items = generateModels(from: it)
                    }
                    .store(in: cancelBag)
            }
            .store(in: cancelBag)

        input.showAddCardTrigger
            .sink {
                homeNavigator.showAddCard()
            }
            .store(in: cancelBag)

        input.showShoppingViewTrigger
            .sink {
                homeNavigator.showShoppingView(certificate: output.certificate)
            }
            .store(in: cancelBag)

        input.showNotificationsTrigger
            .sink {
                homeNavigator.showNotifications()
            }
            .store(in: cancelBag)

        return output
    }
    
    func generateModels(from stats: Statistics) -> [MainCellModel] {
        var items = [MainCellModel]()
        let confirmed = stats.confirmed
        items.append(MainCellModel(
            type: .confirmed,
            title: confirmed != 0 ? "\(confirmed ?? 0)" : "No card".localized(),
            subtitle: "Confirmed cards".localized(),
            leftImage: "list_check"))
        items.append(MainCellModel(
            type: .earned,
            title: String(format: "%.0f ball".localized(), stats.earned ?? 0.0),
            subtitle: "Earned".localized(),
            leftImage: "data"))
        let checking = stats.checking
        items.append(MainCellModel(
            type: .checking,
            title: checking != 0 ? "\(checking ?? 0)" : "No card".localized(),
            subtitle: "Checking...".localized(),
            leftImage: "list_play"))
        let dispute = stats.dispute
        items.append(MainCellModel(
            type: .dispute,
            title: dispute != 0 ? "\(dispute ?? 0)" : "No card".localized(),
            subtitle: "Dispute cards".localized(),
            leftImage: "square_help"))
        let rejected = stats.rejected
        items.append(MainCellModel(
            type: .rejected,
            title: rejected != 0 ? "\(rejected ?? 0)" : "No card".localized(),
            subtitle: "Rejected cards".localized(),
            leftImage: "list_close"))
        let products = stats.products
        items.append(MainCellModel(
            type: .products,
            title: products != 0 ? "\(products ?? 0)" : "Don't have for now".localized(),
            subtitle: "Bought products".localized(),
            leftImage: "shopping_cart"))
        return items
    }
}
