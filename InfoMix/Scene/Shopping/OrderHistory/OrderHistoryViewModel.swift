//
//  OrderHistoryViewModel.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 12/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//


import Combine
import UIKit

struct OrderHistoryViewModel {
    let navigator: OrderHistoryNavigatorType
    let useCase: OrderListUseCaseType
    let statusesUseCase: OrderStatusListUseCaseType
    
    let loadOrderListTrigger = PassthroughSubject<GetOrdersInput, Never>()
    let reloadOrderListTrigger = PassthroughSubject<GetOrdersInput, Never>()
    let loadMoreOrderListTrigger = PassthroughSubject<GetOrdersInput, Never>()
}

// MARK: - ViewModelType
extension OrderHistoryViewModel: ViewModel {
    struct Input {
        let loadOrderStatusListTrigger: Driver<Void>
        let loadOrderListTrigger: Driver<Void>
        let reloadOrderListTrigger: Driver<Void>
        let loadMoreOrderListTrigger: Driver<Void>
        let selectOrderTrigger: Driver<Int>
        let popViewTrigger: Driver<Void>
    }
    
    final class Output: ObservableObject {
        @Published var orders = [Order]()
        @Published var isLoading = false
        @Published var isReloading = false
        @Published var isLoadingMore = false
        @Published var hasMorePages = false
        @Published var alert = AlertMessage()
        @Published var isEmpty = false
        @Published var statuses = [OrderStatus]()
        @Published var selectedStatusValue = "all"
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        
        input.loadOrderListTrigger.handleEvents(receiveOutput: {
            self.loadOrderListTrigger.send(GetOrdersInput(status: output.selectedStatusValue, from: nil, to: nil))
        }).sink().store(in: cancelBag)
        
        input.reloadOrderListTrigger.handleEvents(receiveOutput: {
            self.reloadOrderListTrigger.send(GetOrdersInput(status: output.selectedStatusValue, from: nil, to: nil))
        }).sink().store(in: cancelBag)
        
        input.loadMoreOrderListTrigger.handleEvents(receiveOutput: {
            self.loadMoreOrderListTrigger.send(GetOrdersInput(status: output.selectedStatusValue, from: nil, to: nil))
        }).sink().store(in: cancelBag)
        
        let getStatusListInput = GetListInput(loadTrigger: input.loadOrderStatusListTrigger, reloadTrigger: Driver.empty(), getItems: statusesUseCase.getOrderStatusList)
        
        let (statuses, _, _, _) = getList(input: getStatusListInput).destructured
        
        statuses.assign(to: \.statuses, on: output).store(in: cancelBag)
        
        let getPageInput = GetPageInput(loadTrigger: self.loadOrderListTrigger.asDriver(),
                                        reloadTrigger: self.reloadOrderListTrigger.asDriver(),
                                        loadMoreTrigger: self.loadMoreOrderListTrigger.asDriver(),
                                        getItems: useCase.getOrderList)
        
        let (page, error, isLoading, isReloading, isLoadingMore) = getPage(input: getPageInput).destructured
        
        page
            .handleEvents(receiveOutput: {
                pagingInfo in
                output.hasMorePages = pagingInfo.hasMorePages
                output.orders = pagingInfo.items
            })
            .sink()
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
        
        input.selectOrderTrigger
            .sink { id in
                if let order = output.orders.first(where: { it in
                    it.id == id
                }){
                    navigator.showShoppingCart(order: order)
                }
                
                
            }.store(in: cancelBag)

        input.popViewTrigger.sink {
            navigator.popView()
        }
        .store(in: cancelBag)

        return output
    }
}
