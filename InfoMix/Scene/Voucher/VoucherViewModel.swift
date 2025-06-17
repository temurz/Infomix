//
//  VoucherViewModel.swift
//  InfoMix
//
//  Created by Temur on 13/06/2025.
//  Copyright © 2025 InfoMix. All rights reserved.
//

import Combine
import Foundation
struct VoucherViewModel {
    let navigator: VoucherNavigatorType
    let useCase: VoucherViewUseCaseType
}

extension VoucherViewModel: ViewModel {
    struct Input {
        let popViewTrigger: Driver<Void>
        let onAppearTrigger: Driver<Void>
        let selectStatus: Driver<String>
    }
    
    final class Output: ObservableObject {
        @Published var alert = AlertMessage()
        @Published var isLoading = false
        @Published var from: String = Calendar.current.date(byAdding: .day, value: -7, to: Date())?.toApiFormat() ?? ""
        @Published var to: String = Date().toApiFormat()
        @Published var statuses = [VoucherStatus]()
        @Published var history: VoucherHistoryResponse = .init(id: 0)
        @Published var currency: VoucherCurrency = .init(id: 0)
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        let errorTracker = ErrorTracker()
        let activityTracker = ActivityTracker(false)

        input.popViewTrigger
            .sink {
                navigator.popView()
            }
            .store(in: cancelBag)
        
        input.onAppearTrigger
            .map {
                useCase.getVoucherCurrency()
                    .trackError(errorTracker)
                    .trackActivity(activityTracker)
                    .asDriver()
                    .sink { currency in
                        print("currency")
                        print(currency)
                        output.currency = currency
                    }
                    .store(in: cancelBag)
                
                useCase.getVoucherStatuses()
                    .trackError(errorTracker)
                    .trackActivity(activityTracker)
                    .asDriver()
                    .sink { statuses in
                        print("statuses")
                        print(statuses)
                        output.statuses = statuses
                    }
                    .store(in: cancelBag)
            }
            .sink()
            .store(in: cancelBag)
        
        input.selectStatus
            .map { status in
                useCase.getVoucherHistory(.init(from: output.from, to: output.to, status: "New"), page: .init())
                    .trackError(errorTracker)
                    .trackActivity(activityTracker)
                    .asDriver()
                    .sink { history in
                        print("history")
                        print(history)
                        output.history = history
                    }
                    .store(in: cancelBag)
                     
            }
            .sink()
            .store(in: cancelBag)
        
        errorTracker
            .receive(on: RunLoop.main)
            .map({ AlertMessage(error: $0) })
            .assign(to: \.alert, on: output)
            .store(in: cancelBag)
        
        activityTracker
            .receive(on: RunLoop.main)
            .assign(to: \.isLoading, on: output)
            .store(in: cancelBag)
            
        return output
    }
}
