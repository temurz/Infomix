//
//  ProductCategoryAssembler.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 07/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import UIKit

protocol ProductCategoryAssembler {
    func resolve(navigationController: UINavigationController, intent: ProductCategoryIntent, filteredCategory: ProductCategory?) -> ProductCategoryViewModel
    func resolve(navigationController: UINavigationController, intent: ProductCategoryIntent, filteredCategory: ProductCategory?) -> ProductCategoryView
    func resolve(navigationController: UINavigationController) -> ProductCategoryNavigatorType
    func resolve() -> ProductCategoryUseCaseType
}

extension ProductCategoryAssembler {
    
    
    func resolve(navigationController: UINavigationController, intent: ProductCategoryIntent, filteredCategory: ProductCategory?) -> ProductCategoryView {
        let vm: ProductCategoryViewModel = resolve(navigationController: navigationController, intent: intent, filteredCategory: filteredCategory)
        let vc = ProductCategoryView(viewModel: vm)
        return vc
    }
    
    func resolve(navigationController: UINavigationController, intent: ProductCategoryIntent, filteredCategory: ProductCategory?) -> ProductCategoryViewModel {
        return ProductCategoryViewModel(filteredCategory: filteredCategory, intent: intent, productCategoryUseCase: resolve(), navigator: resolve(navigationController: navigationController))
    }
    
}
extension ProductCategoryAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> ProductCategoryNavigatorType {
        return ProductCategoryNavigator(assembler: self, navigationController: navigationController)
    }
  
    func resolve() -> ProductCategoryUseCaseType{
        return ProductCategoryUseCase(productCategoryGateway: resolve())
    }
    
}

extension ProductCategoryAssembler where Self: PreviewAssembler {
    func resolve(navigationController: UINavigationController) -> ProductCategoryNavigatorType {
        return ProductCategoryNavigator(assembler: self, navigationController: navigationController)
    }
  
    func resolve() -> ProductCategoryUseCaseType{
        return ProductCategoryUseCase(productCategoryGateway: resolve())
    }
  
}
