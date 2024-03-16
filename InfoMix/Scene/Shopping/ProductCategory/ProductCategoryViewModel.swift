//
//  ProductCategoryViewModel.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 07/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//


import Combine
import SwiftUI

struct ProductCategoryViewModel {
    let filteredCategory: ProductCategory?
    let intent: ProductCategoryIntent
    let productCategoryUseCase: ProductCategoryUseCaseType
    let navigator: ProductCategoryNavigatorType
    let loadTrigger = PassthroughSubject<Optional<Int>,Never>()
    let reloadTrigger = PassthroughSubject<Optional<Int>,Never>()
}

extension ProductCategoryViewModel : ViewModel {
    
    struct Input {
        let loadTrigger: Driver<Void>
        let reloadTrigger: Driver<Void>
        let selectProductCategoryTrigger: Driver<IndexPath>
        let closeTrigger: Driver<Void>
        let backTrigger: Driver<Void>
    }
    
    final class Output: ObservableObject {
        @Published var isLoading: Bool = false
        @Published var isReloading: Bool = false
        @Published var alert: AlertMessage = AlertMessage()
        @Published var categories = [ProductCategory]()
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        
        let getListInput = GetListInput(loadTrigger: self.loadTrigger.asDriver(), reloadTrigger: self.reloadTrigger.asDriver(), getItems: self.productCategoryUseCase.getProductCategoryList)
        
        let (categories, error, isLoading, isReloading) = getList(input: getListInput).destructured
        
        categories.sink { it in
            output.categories = it
        }.store(in: cancelBag)
        isLoading.assign(to: \.isLoading, on: output)
            .store(in: cancelBag)
        
        
        isReloading.assign(to: \.isReloading, on: output)
            .store(in: cancelBag)
        
        error
            .receive(on: RunLoop.main)
            .map { AlertMessage(error: $0) }
            .assign(to: \.alert, on: output)
            .store(in: cancelBag)
        
        input.loadTrigger.sink { _ in
            let parentId = intent.parentIds.last ?? 0
            self.loadTrigger.send(parentId)
        }.store(in: cancelBag)
        
        
        input.reloadTrigger.sink { _ in
            let parentId = intent.parentIds.last ?? 0
            self.reloadTrigger.send(parentId)
        }.store(in: cancelBag)
        
        input.closeTrigger.sink { _ in
            if let filteredCategory = self.filteredCategory {
                self.navigator.showProductList(category: filteredCategory)
            } else {
                self.navigator.showHome()
            }
        }.store(in: cancelBag)
        
        input.backTrigger.sink { _ in
           
            if intent.parentIds.isEmpty {
                if let filteredCategory = self.filteredCategory {
                    self.navigator.showProductList(category: filteredCategory)
                } else {
                    self.navigator.showHome()
                }
            } else {
                var newIntent = intent
                newIntent.parentIds.removeLast()
                self.navigator.showProductCategoryList(intent: newIntent, filteredCategory: filteredCategory)
            }
                
        
            
        }.store(in: cancelBag)
        
        
        
        input.selectProductCategoryTrigger.handleEvents(receiveOutput: {
            indexPath in
            
            var category = output.categories[indexPath.row]
            
            if category.childrenCount > 0 {
                var newIntent = intent
                newIntent.parentIds.append(category.id)
                self.navigator.showProductCategoryList(intent: newIntent, filteredCategory: filteredCategory)
            }else {
                category.intent = intent
                self.navigator.showProductList(category: category)
            }
        }).sink().store(in: cancelBag)
        
        return output
    }
    
}
