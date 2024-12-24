//
//  StatusViewModel.swift
//  InfoMix
//
//  Created by Temur on 16/12/2024.
//  Copyright © 2024 InfoMix. All rights reserved.
//
import Combine
import Foundation
struct StatusViewModel {
    let navigator: StatusViewNavigatorType
    let useCase: StatusViewUseCaseType
    let loyalty: Loyalty?
}

extension StatusViewModel: ViewModel {
    struct Input {
        let popViewTrigger: Driver<Void>
        let loadLoyaltyTrigger: Driver<Void>
        let loadTrigger: Driver<Void>
        let loadMoreTrigger: Driver<Void>
    }
    
    final class Output: ObservableObject {
        @Published var loyalty: Loyalty?
        @Published var leaderboard = [LoyalUser]()
        @Published var hasMorePages = false
        @Published var alert = AlertMessage()
        @Published var isLoading = false
        @Published var isReloading = false
        @Published var isLoadingMore = false

        init(loyalty: Loyalty?) {
            self.loyalty = loyalty
        }
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output(loyalty: self.loyalty)

        input.popViewTrigger
            .sink {
                navigator.popView()
            }
            .store(in: cancelBag)

        let getPageInput = GetPageInput(loadTrigger: input.loadTrigger, reloadTrigger: Driver.empty(), loadMoreTrigger: input.loadMoreTrigger, getItems: useCase.getLeaderboard)

        let (page,
             error,
             isLoading,
             isReloading,
             isLoadingMore) = getPage(input: getPageInput).destructured

        page
            .handleEvents(receiveOutput: {
                page in
                output.hasMorePages = page.hasMorePages
            })
            .map { $0.items.map { $0 } }
            .assign(to: \.leaderboard, on: output)
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

        input.loadLoyaltyTrigger
            .sink {
                useCase.getLoyalty()
                    .asDriver()
                    .sink { loyalty in
                        output.loyalty = loyalty
                    }
                    .store(in: cancelBag)
            }
            .store(in: cancelBag)

        return output
    }
}
