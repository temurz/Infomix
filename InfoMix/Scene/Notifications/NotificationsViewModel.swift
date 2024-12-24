//
//  NotificationsViewModel.swift
//  CleanArchitecture
//
//  Created by Temur on 22/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Foundation
import Combine

struct NotificationsViewModel{
    let navigator : NotificationsNavigatorType
    let useCase: NotificationsUseCaseType
}

extension NotificationsViewModel : ViewModel {
    
    struct Input {
        let loadNotificationsTrigger: Driver<Void>
        let reloadNotificationsTrigger: Driver<Void>
        let loadMoreNotificationsTrigger: Driver<Void>
        let popViewTrigger: Driver<Void>
        let moreActionTrigger: Driver<NotificationsItemViewModel>
    }
    
    final class Output : ObservableObject {
        @Published var notifications = [NotificationsItemViewModel]()
        @Published var isLoading = false
        @Published var isReloading = false
        @Published var isLoadingMore = false
        @Published var alert = AlertMessage()
        @Published var isEmpty = false
        @Published var hasMorePages = false
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        
        
        let getPageInput = GetPageInput(loadTrigger: input.loadNotificationsTrigger, reloadTrigger: input.reloadNotificationsTrigger, loadMoreTrigger: input.loadMoreNotificationsTrigger, getItems: useCase.getNotifications)
        
        let (page,error, isLoading, isReloading, isLoadingMore) = getPage(input: getPageInput).destructured
        
        page
            .handleEvents(receiveOutput: {
                page in
                output.hasMorePages = page.hasMorePages
            })
            .map { $0.items.map(NotificationsItemViewModel.init) }
            .assign(to: \.notifications, on: output)
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
        
        input.moreActionTrigger.sink { notification in
            switch notification.notification.subject {
            case .EVENT:
                self.navigator.toEventDetail(id: Int32(notification.objectId))
            case .SYSTEM:
                break
            case .SCORE:
                self.navigator.toTransactionList()
            case .ORDER:
                self.navigator.toOrder(id: notification.objectId)
            case .PRICE:
                break
            case .PAYMENT:
                break
            case .DISPUTE:
                break
            case .PENALTY:
                break
            }
        }.store(in: cancelBag)

        input.popViewTrigger.sink {
            navigator.popView()
        }
        .store(in: cancelBag)

        return output
    }
}
