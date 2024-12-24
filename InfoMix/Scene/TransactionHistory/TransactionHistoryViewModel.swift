//
//  TransactionViewModel.swift
//  CleanArchitecture
//
//  Created by Temur on 08/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Combine
import UIKit
import SwiftUI
import Foundation

public enum BottomSheetPosition1: CGFloat, CaseIterable {
    case middle = 0.5, hidden = 0
}

struct TransactionHistoryViewModel{
    
    let useCase : TransactionHistoryUseCaseType
    let typesUseCase : TransactionTypeUseCaseType
    let statisticUseCase : TransactionStatisticUseCaseType
    let navigator : TransactionHistoryNavigatorType
    let loadHistoryTrigger = PassthroughSubject<TransactionHistoryInput, Never>()
    let reloadHistoryTrigger = PassthroughSubject<TransactionHistoryInput, Never>()
    let loadMoreHistoryTrigger = PassthroughSubject<TransactionHistoryInput, Never>()
    let loadTransactionStatisticTrigger = PassthroughSubject<TransactionStatisticInput, Never>()
}

extension TransactionHistoryViewModel : ViewModel{
    
    struct Input {
        let loadTransactionHistoryTrigger : Driver<Void>
        let reloadTransactionHistoryTrigger : Driver<Void>
        let loadMoreTransactionHistoryTrigger : Driver<Void>
        let selectCalendarTrigger : Driver<Void>
        let loadTransactionTypesListTrigger : Driver<Void>
        let loadTransactionStatisticTrigger : Driver<Void>
        let popViewTrigger : Driver<Void>
    }
    
    final class Output : ObservableObject {
        @Published var transactionHistory = [TransactionHistoryItemViewModel]()
        @Published var transactionTypes = [TransactionType]()
        @Published var transactionStatistic = TransactionStatistic()
        @Published var isLoading = false
        @Published var isReloading = false
        @Published var isLoadingMore = false
        @Published var isEmpty = false
        @Published var hasMorePages = false
        @Published var alert = AlertMessage()
        @Published var from = Date().startOfMonth
        @Published var to = Date()
        @Published var type: String = "all"
        @Published var bottomSheetPosition: BottomSheetPosition1 = .hidden
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        
        let output = Output()

        input.popViewTrigger
            .sink {
                navigator.popView()
            }
            .store(in: cancelBag)

        input.loadTransactionHistoryTrigger.handleEvents(receiveOutput: {
            self.loadHistoryTrigger.send(TransactionHistoryInput(from: output.from, to: output.to, type: output.type == "All" ? nil : output.type))
        }).sink().store(in: cancelBag)
        
        
        input.reloadTransactionHistoryTrigger.handleEvents(receiveOutput: {
            self.reloadHistoryTrigger.send(TransactionHistoryInput(from: output.from, to: output.to, type: output.type == "All" ? nil : output.type))
        }).sink().store(in: cancelBag)
        
        
        input.loadMoreTransactionHistoryTrigger.handleEvents(receiveOutput: {
            self.loadMoreHistoryTrigger.send(TransactionHistoryInput(from: output.from, to: output.to, type: output.type == "All" ? nil : output.type))
        }).sink().store(in: cancelBag)
        
        input.loadTransactionStatisticTrigger.handleEvents(receiveOutput: {
            self.loadTransactionStatisticTrigger.send(TransactionStatisticInput(from: output.from, to: output.to))
        }).sink().store(in: cancelBag)
        
        let getStatisticInput = GetItemInput(loadTrigger: self.loadTransactionStatisticTrigger.asDriver(), reloadTrigger: Driver.empty(), getItem: statisticUseCase.getTransactionStatistic)
        
        let (statistic, _, _, _) = getItem(input: getStatisticInput).destructured
        
        statistic.assign(to: \.transactionStatistic, on: output).store(in: cancelBag)
        
        let getTypeListInput = GetListInput(loadTrigger: input.loadTransactionTypesListTrigger, reloadTrigger: Driver.empty(), getItems: typesUseCase.getTransactionTypes)
        
        let (types,_,_,_) = getList(input: getTypeListInput).destructured
        
        types.assign(to: \.transactionTypes, on: output).store(in: cancelBag)
        
        let getPageInput = GetPageInput(loadTrigger: self.loadHistoryTrigger.asDriver(),
                                        reloadTrigger: self.reloadHistoryTrigger.asDriver(),
                                        loadMoreTrigger: self.loadMoreHistoryTrigger.asDriver(),
                                         getItems: useCase.getTransactionHistory)
        
        let (page,error,isLoading,isReloading,isLoadingMore) = getPage(input: getPageInput).destructured
        
        page
            .handleEvents(receiveOutput:{
                pagingInfo in
                output.hasMorePages = pagingInfo.hasMorePages
            })
            .map { $0.items.map(TransactionHistoryItemViewModel.init) }
            .assign(to: \.transactionHistory, on: output)
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
        input.selectCalendarTrigger.sink(receiveCompletion: { it in
            
        }) {
            withAnimation(.linear) {
                output.bottomSheetPosition = .middle
            }
                
                
        }.store(in: cancelBag)
        
        return output
    }
}
