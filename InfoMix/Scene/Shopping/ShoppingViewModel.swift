//
//  ShoppingViewModel.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 06/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Combine
import SwiftUI

struct ShoppingViewModel {
    let certificate: CertificateItemViewModel
    let currentShoppingCartUseCase: CurrentShoppingCartUseCaseType
    let addToCartUseCase: AddToCartUseCaseType
    let topProductListUseCase: TopProductListUseCaseType
    let navigator: ShoppingNavigatorType
    let addToCartTrigger = PassthroughSubject<AddToCartInput,Never>()
}

extension ShoppingViewModel : ViewModel {
    
    struct Input {
        let loadShoppingCartTrigger: Driver<Void>
        let shopByDepartmentTrigger: Driver<Void>
        let showAllProductsTrigger: Driver<Void>
        let addToCartTrigger: Driver<Void>
        let showOrderHistoryTrigger: Driver<Void>
        let showShoppingCartTrigger: Driver<Void>
        let showProductDetailTrigger: Driver<Int>
        let loadTopProductListTrigger: Driver<Void>
        let popViewTrigger: Driver<Void>
    }
    
    final class Output: ObservableObject {
        
        @Published var certificate: CertificateItemViewModel
        @Published var shoppingCart: Order = Order()
        @Published var isLoadingShoppingCart: Bool = true
        @Published var isLoadingTopProducts: Bool = false
        @Published var isAddingToCart: Bool = false
        @Published var alert: AlertMessage = AlertMessage()
        @Published var products = [ProductItemViewModel]()
        @Published var showingProductItemModel = ProductItemViewModel(product: Product())
        @Published var bottomSheetPosition: ProductDetailBottomSheetPosition = .hidden
        @Published var quantity = 1
        
        
        
        
        init(certificate: CertificateItemViewModel){
            self.certificate = certificate
        }
        
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output(certificate: self.certificate)
        
        //GET TOP PRODUCTS
        let getTopProductsInput = GetListInput(loadTrigger: input.loadTopProductListTrigger, reloadTrigger: .empty(), getItems: self.topProductListUseCase.getTopProductList)
        
        let (topProducts, _, isLoadingTopProducts, _) = getList(input: getTopProductsInput).destructured
        
        
        topProducts.map{ $0.map(ProductItemViewModel.init) }.assign(to: \.products, on: output)
            .store(in: cancelBag)
        
        isLoadingTopProducts.assign(to: \.isLoadingTopProducts, on: output)
            .store(in: cancelBag)
     
        
        //CURRENT SHOPPING CART
        let currentShoppingCartInput = GetItemInput(loadTrigger: input.loadShoppingCartTrigger, reloadTrigger: Driver.empty(), getItem: self.currentShoppingCartUseCase.currentShoppingCart)
        
        let (shoppingCart, errorLoadCurrentOrder, isLoadingCurrentOrder, _) = getItem(input: currentShoppingCartInput).destructured
        
        
        shoppingCart.assign(to: \.shoppingCart, on: output)
            .store(in: cancelBag)
        
        isLoadingCurrentOrder.assign(to: \.isLoadingShoppingCart, on: output)
            .store(in: cancelBag)
        
        
        errorLoadCurrentOrder
            .receive(on: RunLoop.main)
            .map { AlertMessage(error: $0) }
            .assign(to: \.alert, on: output)
            .store(in: cancelBag)
        
        
        input.shopByDepartmentTrigger.handleEvents(receiveOutput: {
            self.navigator.showProductCategoryList()
        }).sink()
            .store(in: cancelBag)
        
        input.showAllProductsTrigger.handleEvents(receiveOutput: {
            self.navigator.showProductList()
        }).sink()
            .store(in: cancelBag)
        
        input.showOrderHistoryTrigger.handleEvents(receiveOutput: {
            self.navigator.showOrderHistory()
        }).sink()
            .store(in: cancelBag)
        
    
        input.showShoppingCartTrigger.handleEvents(receiveOutput: {
            self.navigator.showShoppingCart(order: output.shoppingCart)
        }).sink()
            .store(in: cancelBag)
        
        input.showProductDetailTrigger
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

        let addToCartInput = GetItemInput(loadTrigger: self.addToCartTrigger.asDriver(),
                                      reloadTrigger: Driver.empty(),
                                      getItem: addToCartUseCase.addToCart)

        let (newShoppingCart, errorAddToCart, isAddingToCart, _) = getItem(input: addToCartInput).destructured


        newShoppingCart.handleEvents(receiveOutput: {
            _ in
            withAnimation(.easeOut(duration: 0.2)) {
                output.bottomSheetPosition = .hidden
            }
        })
        .map({ entry in
            output.shoppingCart.addOrUpdate(entry: entry)
            return output.shoppingCart
        })
        .assign(to: \.shoppingCart, on: output)
        .store(in: cancelBag)

        isAddingToCart.assign(to: \.isAddingToCart, on: output)
            .store(in: cancelBag)

        errorAddToCart
            .receive(on: RunLoop.main)
            .map { AlertMessage(error: $0) }
            .assign(to: \.alert, on: output)
            .store(in: cancelBag)

        input.popViewTrigger
            .sink {
                navigator.popView()
            }
            .store(in: cancelBag)

        return output
    }
    
}
