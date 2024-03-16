//
//  ShoppingCartViewModel.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 10/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Combine
import SwiftUI

struct ShoppingCartViewModel {
    let shoppingCart: Order
    let orderUseCase: GetOrderUseCaseType
    let updateProductEntryUseCase: UpdateProductEntryUseCaseType
    let deleteProductEntryUseCase: DeleteProductEntryUseCaseType
    let checkoutUseCase: ShoppingCartCheckoutUseCaseType
    let cancelOrderUseCase: CancelOrderUseCaseType
    let clearShoppingCartUseCase: ClearShoppingCartUseCaseType
    let navigator: ShoppingCartNavigatorType
    let checkoutTrigger = PassthroughSubject<Int, Never>()
    let clearShoppingCartTrigger = PassthroughSubject<Int, Never>()
    let cancelOrderTrigger = PassthroughSubject<Int, Never>()
    let loadOrderTrigger = PassthroughSubject<Int, Never>()
}

// MARK: - ViewModelType
extension ShoppingCartViewModel: ViewModel {
    
    
    struct Input {
        let loadOrderTrigger: Driver<Void>
        let updateEntryTrigger: Driver<UpdateProductEntryInput>
        let deleteEntryTrigger: Driver<Int>
        let checkoutTrigger: Driver<Void>
        let clearShoppingCartTrigger: Driver<Void>
        let cancelOrderTrigger: Driver<Void>
        let showAllProductsTrigger: Driver<Void>
    }
    
    final class Output: ObservableObject {
        @Published var shoppingCart: Order
        @Published var alert = AlertMessage()
        @Published var isDeleting = false
        @Published var isUpdating = false
        @Published var isCheckingOut = false
        @Published var isClearing = false
        @Published var isCanceling = false
        @Published var isLoading = false
        @Published var checkedOut = false
        
        init(shoppingCart: Order){
            self.shoppingCart = shoppingCart
        }
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output(shoppingCart: self.shoppingCart)
        
        //Load Order
        input.loadOrderTrigger.handleEvents(receiveOutput: {
            self.loadOrderTrigger.send(self.shoppingCart.id)
        }).sink().store(in: cancelBag)
        
        let getOrderInput = GetItemInput(loadTrigger: self.loadOrderTrigger.asDriver(), reloadTrigger: Driver.empty(), getItem: self.orderUseCase.getOrder)
        
        let (order, error, isLoading, _) = getItem(input: getOrderInput).destructured
        
        order.assign(to: \.shoppingCart, on: output).store(in: cancelBag)
        
        error
            .receive(on: RunLoop.main)
            .map { AlertMessage(error: $0) }
            .assign(to: \.alert, on: output)
            .store(in: cancelBag)
        
        isLoading.assign(to: \.isLoading, on: output).store(in: cancelBag)
        
        
      
        //Delete Order
        let deleteEntryInput = GetItemInput(loadTrigger: input.deleteEntryTrigger, reloadTrigger: Driver.empty(), getItem: self.deleteProductEntryUseCase.deleteProductEntry)
        
        let (shoppingCartAfterDelete, errorDeleteProductEntry, isDeletingProductEntry, _) = getItem(input: deleteEntryInput).destructured
        
        shoppingCartAfterDelete.assign(to: \.shoppingCart, on: output).store(in: cancelBag)
        
        errorDeleteProductEntry
            .receive(on: RunLoop.main)
            .map { AlertMessage(error: $0) }
            .assign(to: \.alert, on: output)
            .store(in: cancelBag)
        
        isDeletingProductEntry.assign(to: \.isDeleting, on: output).store(in: cancelBag)
        
        // Update Order
        
        let updateEntryInput = GetItemInput(loadTrigger: input.updateEntryTrigger, reloadTrigger: Driver.empty(), getItem: self.updateProductEntryUseCase.updateProductEntry)
        
        let (shoppingCartAfterUpdate, errorUpdateProductEntry, isUpdatingProductEntry, _) = getItem(input: updateEntryInput).destructured
        
        shoppingCartAfterUpdate.assign(to: \.shoppingCart, on: output).store(in: cancelBag)
        
        errorUpdateProductEntry
            .receive(on: RunLoop.main)
            .map { AlertMessage(error: $0) }
            .assign(to: \.alert, on: output)
            .store(in: cancelBag)
        
        isUpdatingProductEntry.assign(to: \.isUpdating, on: output).store(in: cancelBag)
        
        //CHeckout Order
        input.checkoutTrigger.handleEvents(receiveOutput: {
            self.checkoutTrigger.send(output.shoppingCart.id)
        }).sink().store(in: cancelBag)
        
        
        let checkoutInput = GetItemInput(loadTrigger: self.checkoutTrigger.asDriver(), reloadTrigger: Driver.empty(), getItem: self.checkoutUseCase.checkout)
        
        let (checkedOrder, errorCheckout, isCheckingOut, _) = getItem(input: checkoutInput).destructured
        
        checkedOrder.handleEvents(receiveOutput: {
            order in
            output.shoppingCart = order
            output.checkedOut = true
        }).sink().store(in: cancelBag)
        
        errorCheckout
            .receive(on: RunLoop.main)
            .map { AlertMessage(error: $0) }
            .assign(to: \.alert, on: output)
            .store(in: cancelBag)
        
        isCheckingOut.assign(to: \.isCheckingOut, on: output).store(in: cancelBag)
        
        // Clear Shopping Cart
        
        input.clearShoppingCartTrigger.handleEvents(receiveOutput: {
            self.clearShoppingCartTrigger.send(output.shoppingCart.id)
        }).sink().store(in: cancelBag)
        
        let clearShoppingCartInput = GetItemInput(loadTrigger: self.clearShoppingCartTrigger.asDriver(), reloadTrigger: Driver.empty(), getItem: self.clearShoppingCartUseCase.clearShoppingCart)
        
        let (shoppingCart, errorClearShoppingCart, isClearing, _) = getItem(input: clearShoppingCartInput).destructured
        
        shoppingCart.assign(to: \.shoppingCart, on: output).store(in: cancelBag)
        
        errorClearShoppingCart
            .receive(on: RunLoop.main)
            .map { AlertMessage(error: $0) }
            .assign(to: \.alert, on: output)
            .store(in: cancelBag)
        
        isClearing.assign(to: \.isClearing, on: output).store(in: cancelBag)
        
        //Cancel Order
        input.cancelOrderTrigger.handleEvents(receiveOutput: {
            self.cancelOrderTrigger.send(output.shoppingCart.id)
        }).sink().store(in: cancelBag)
        
        let cancelOrderInput = GetItemInput(loadTrigger: self.cancelOrderTrigger.asDriver(), reloadTrigger: Driver.empty(), getItem: self.cancelOrderUseCase.cancelOrder)
        
        let (canceledOrder, errorCancelOrder, isCanceling, _) = getItem(input: cancelOrderInput).destructured
        
        canceledOrder.handleEvents(receiveOutput: { order in
            output.shoppingCart.status = order.status
            output.shoppingCart.statusText = order.statusText
        }).sink().store(in: cancelBag)
        
        errorCancelOrder
            .receive(on: RunLoop.main)
            .map { AlertMessage(error: $0) }
            .assign(to: \.alert, on: output)
            .store(in: cancelBag)
        
        isCanceling.assign(to: \.isCanceling, on: output).store(in: cancelBag)
        
        input.showAllProductsTrigger.handleEvents(receiveOutput: {
            self.navigator.showProductList()
        }).sink().store(in: cancelBag)
        
        return output
    }
  
}
    
