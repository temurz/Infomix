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
        let filterTrigger: Driver<Void>
        let onAppearTrigger: Driver<Void>
        let selectStatus: Driver<String>
        let addVoucherTrigger: Driver<Void>
        let requestVoucherTrigger: Driver<(String, String)>
        let cancelRequestTrigger: Driver<Int>
        let getBarcodetrigger: Driver<String>
    }
    
    final class Output: ObservableObject {
        @Published var alert = AlertMessage()
        @Published var isLoading = false
        @Published var isShowingAddVoucher = false
        @Published var from: String = Calendar.current.date(byAdding: .day, value: -7, to: Date())?.toApiFormat() ?? ""
        @Published var to: String = Date().toApiFormat()
        @Published var statuses = [VoucherStatus]()
        @Published var history: [VoucherHistoryResponse] = []
        @Published var currency: VoucherCurrency = .init(id: 0)
        @Published var selectedStatus: VoucherStatus?
        @Published var requestAmount: String = ""
        @Published var comment: String = ""
        @Published var requestAmountError: String = ""
        @Published var isVoucherRequestEnabled = true
        @Published var showBarcode = false
        @Published var showFilter = false
        @Published var barcode = ""
        @Published var balance: Double = 0.0
        @Published var fromDate: Date = Calendar.current.date(byAdding: .day, value: -7, to: Date()) ?? Date()
        @Published var toDate: Date = Date()
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        let errorTracker = ErrorTracker()
        let activityTracker = ActivityTracker(false)

        let amountValidation = Publishers
            .CombineLatest(output.$requestAmount, input.requestVoucherTrigger)
            .map { $0.0 }
            .map { VoucherDto.validateAmount($0) }
        
        amountValidation
            .asDriver()
            .map { $0.message }
            .assign(to: \.requestAmountError, on: output)
            .store(in: cancelBag)
        
        amountValidation
            .map { $0.isValid }
            .assign(to: \.isVoucherRequestEnabled, on: output)
            .store(in: cancelBag)
        
        input.popViewTrigger
            .sink {
                navigator.popView()
            }
            .store(in: cancelBag)
        
        input.onAppearTrigger
            .map {
                output.balance = UserDefaults.standard.value(forKey: "balance") as? Double ?? 0.0
                useCase.getVoucherCurrency()
                    .trackError(errorTracker)
                    .trackActivity(activityTracker)
                    .asDriver()
                    .sink { currency in
                        output.currency = currency
                    }
                    .store(in: cancelBag)
                
                useCase.getVoucherStatuses()
                    .trackError(errorTracker)
                    .trackActivity(activityTracker)
                    .asDriver()
                    .sink { statuses in
                        let firstStatus = statuses.first
                        let updatedStatus = statuses.map {
                            if $0.valueField == firstStatus?.valueField {
                                return VoucherStatus(valueField: $0.valueField, textField: $0.textField, selected: true)
                            }
                            return $0
                        }
                        output.statuses = updatedStatus
                        
                    }
                    .store(in: cancelBag)
            }
            .sink()
            .store(in: cancelBag)
        
        input.selectStatus
            .map { status in
                let updatedStatus = output.statuses.map {
                    return VoucherStatus(valueField: $0.valueField, textField: $0.textField, selected: false)
                }
                output.statuses = updatedStatus.map({
                    if $0.id == status {
                        let selectedStatus = VoucherStatus(valueField: $0.valueField, textField: $0.textField, selected: true)
                        output.selectedStatus = selectedStatus
                        return selectedStatus
                    }
                    return VoucherStatus(valueField: $0.valueField, textField: $0.textField, selected: false)
                })
                useCase.getVoucherHistory(.init(from: output.fromDate.toApiFormat(), to: output.toDate.toApiFormat(), status: status), page: .init())
                    .trackActivity(activityTracker)
                    .asDriver()
                    .sink { history in
                        output.history = history
                    }
                    .store(in: cancelBag)
                     
            }
            .sink()
            .store(in: cancelBag)
        
        input.addVoucherTrigger
            .sink {
                output.isShowingAddVoucher = true
            }
            .store(in: cancelBag)
        
        input.requestVoucherTrigger
            .delay(for: 0.1, scheduler: RunLoop.main)
            .filter { _ in output.isVoucherRequestEnabled }
            .sink { input in
                if let amount = Double(input.0) {
                    useCase.voucherRequest(amount: amount, comment: input.1)
                        .trackError(errorTracker)
                        .trackActivity(activityTracker)
                        .asDriver()
                        .sink { response in
                            output.isShowingAddVoucher = false
                            output.requestAmount = ""
                            output.alert = AlertMessage(title: "Success".localized(), message: "Successfully requested voucher".localized(), isShowing: true)
                        }
                        .store(in: cancelBag)
                }
                
            }
            .store(in: cancelBag)
        
        input.cancelRequestTrigger
            .sink { id in
                useCase.cancelVoucher(id)
                    .trackError(errorTracker)
                    .trackActivity(activityTracker)
                    .asDriver()
                    .sink { bool in
                        output.alert = AlertMessage(title: "Success".localized(), message: "Successfully canceled".localized(), isShowing: true)
                    }
                    .store(in: cancelBag)
            }
            .store(in: cancelBag)
        
        input.getBarcodetrigger
            .sink { code in
                output.barcode = code
                output.showBarcode = true
            }
            .store(in: cancelBag)
        
        input.filterTrigger
            .sink {
                output.showFilter = true
            }
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
