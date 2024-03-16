//
//  ProductsViewModel.swift
//  CleanArchitecture
//
//  Created by Tuan Truong on 7/14/20.
//  Copyright © 2020 Tuan Truong. All rights reserved.
//

import Combine
import UIKit
import SwiftUI

//The custom BottomSheetPosition enum with absolute values.
public enum ProductDetailBottomSheetPosition: CGFloat, CaseIterable {
    case middle = 0.8, hidden = 0
}


struct ProductsViewModel {
    let category: ProductCategory?
    let navigator: ProductsNavigatorType
    let productsUseCase: ProductsUseCaseType
    let addToCartUseCase: AddToCartUseCaseType
    let currentShoppingCartUseCase: CurrentShoppingCartUseCaseType
    let addToCartTrigger = PassthroughSubject<AddToCartInput,Never>()
    let loadTrigger =  PassthroughSubject<GetProductsInput, Never>()
    let reloadTrigger = PassthroughSubject<GetProductsInput, Never>()
    let loadMoreTrigger = PassthroughSubject<GetProductsInput, Never>()
}

// MARK: - ViewModelType
extension ProductsViewModel: ViewModel {
    struct Input {
        let loadShoppingCartTrigger: Driver<Void>
        let loadTrigger: Driver<Void>
        let reloadTrigger: Driver<Void>
        let loadMoreTrigger: Driver<Void>
        let selectTrigger: Driver<Int>
        let addToCartTrigger: Driver<Void>
        let showShoppingCartTrigger: Driver<Void>
        let showProductCategoryTrigger: Driver<Void>
        let clearProductCategoryFilter: Driver<Void>
    }
    
    final class Output: ObservableObject {
        @Published var category: ProductCategory? = nil
        @Published var products = [ProductItemViewModel]()
        @Published var isLoading = false
        @Published var isReloading = false
        @Published var isAdding = false
        @Published var isLoadingMore = false
        @Published var hasMorePages = false
        @Published var alert = AlertMessage()
        @Published var shoppingCart = Order()
        @Published var query = ""
        @Published var showingProductItemModel = ProductItemViewModel(product: Product())
        @Published var bottomSheetPosition: ProductDetailBottomSheetPosition = .hidden
        @Published var quantity = 1
        
        
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        
        
        let output = Output()
        output.category = self.category
        
        let getShoppingCartInput = GetItemInput(loadTrigger: input.loadShoppingCartTrigger, reloadTrigger: Driver.empty(), getItem: self.currentShoppingCartUseCase.currentShoppingCart)
        
        let (shoppingCart, errorGettingShoppingCart, _, _) = getItem(input: getShoppingCartInput).destructured
        
        
        shoppingCart
            .assign(to: \.shoppingCart, on: output)
            .store(in: cancelBag)
        
        errorGettingShoppingCart
            .receive(on: RunLoop.main)
            .map { AlertMessage(error: $0) }
            .assign(to: \.alert, on: output)
            .store(in: cancelBag)
        
        input.loadTrigger.handleEvents(receiveOutput: { _ in
            self.loadTrigger.send(GetProductsInput(categoryId: output.category?.id, query: output.query))
        }).sink().store(in: cancelBag)
        
        input.reloadTrigger.handleEvents(receiveOutput: { _ in
            self.reloadTrigger.send(GetProductsInput(categoryId: output.category?.id, query: output.query))
        }).sink().store(in: cancelBag)
        
        input.loadMoreTrigger.handleEvents(receiveOutput: { _ in
            self.loadMoreTrigger.send(GetProductsInput(categoryId: output.category?.id, query: output.query))
        }).sink().store(in: cancelBag)
        
        input.showShoppingCartTrigger.handleEvents(receiveOutput: { _ in
            self.navigator.showShoppingCart(order: output.shoppingCart)
        }).sink().store(in: cancelBag)
        
        
        let getPageInput = GetPageInput(loadTrigger: self.loadTrigger.asDriver(),
                                        reloadTrigger: self.reloadTrigger.asDriver(),
                                        loadMoreTrigger: self.loadMoreTrigger.asDriver(),
                                        getItems: productsUseCase.getProducts)
        
        let (products, error, isLoading, isReloading, isLoadingMore) = getPage(input: getPageInput).destructured
        
        products
            .handleEvents(receiveOutput : {
                pagingInfo in
                output.hasMorePages = pagingInfo.hasMorePages
                output.products = pagingInfo.items.map(ProductItemViewModel.init)
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
        
        input.selectTrigger
            .sink(receiveValue: { id in
                if let productItemModel = output.products.first(where: { it in
                    it.id == id
                }){
                    output.showingProductItemModel = productItemModel
                    output.quantity = 1
                    withAnimation(.easeOut(duration: 0.2)) {
                        output.bottomSheetPosition = .middle
                    }
                }
            })
            .store(in: cancelBag)
        
        input.addToCartTrigger
            .sink(receiveValue: {
                self.addToCartTrigger.send(AddToCartInput(product: output.showingProductItemModel.product,
                                                          quantity: output.quantity))
            })
            .store(in: cancelBag)
        
        
        //Add to cart
        let addToCartInput = GetItemInput(loadTrigger: self.addToCartTrigger.asDriver(),
                                          reloadTrigger: Driver.empty(),
                                          getItem: addToCartUseCase.addToCart)
        
        let (order, errorAddToCart, isAdding, _) = getItem(input: addToCartInput).destructured
        
        order
            .handleEvents(receiveOutput: {
                _ in
                withAnimation(.easeOut(duration: 0.2)) {
                    output.bottomSheetPosition = .hidden
                }
            })
            .assign(to: \.shoppingCart, on: output)
            .store(in: cancelBag)
        
        
        isAdding
            .assign(to: \.isAdding, on: output)
            .store(in: cancelBag)
        
        
        errorAddToCart
            .receive(on: RunLoop.main)
            .map { AlertMessage(error: $0) }
            .assign(to: \.alert, on: output)
            .store(in: cancelBag)
        
        input.clearProductCategoryFilter.handleEvents(receiveOutput : {
            output.category = nil
        }).sink().store(in: cancelBag)
        
        
        input.showProductCategoryTrigger.handleEvents(receiveOutput : {
            self.navigator.showProductCategoryList(filteredCategory: output.category)
        }).sink().store(in: cancelBag)
        
        
        
        return output
    }
}
