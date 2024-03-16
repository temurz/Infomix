//
//  ProductsAssembler.swift
//  CleanArchitecture
//
//  Created by Tuan Truong on 7/14/20.
//  Copyright © 2020 Tuan Truong. All rights reserved.
//

import UIKit

protocol ProductsAssembler {
    func resolve(navigationController: UINavigationController, category: ProductCategory?) -> ProductsView
    func resolve(navigationController: UINavigationController, category: ProductCategory?) -> ProductsViewModel
    func resolve(navigationController: UINavigationController) -> ProductsNavigatorType
    func resolve() -> ProductsUseCaseType
    func resolve() -> AddToCartUseCaseType
    func resolve() -> CurrentShoppingCartUseCaseType
}

extension ProductsAssembler {
    func resolve(navigationController: UINavigationController, category: ProductCategory?) -> ProductsView {
        return ProductsView(viewModel: resolve(navigationController: navigationController,category: category))
    }
    
    func resolve(navigationController: UINavigationController, category: ProductCategory?) -> ProductsViewModel {
        return ProductsViewModel(
            category: category,
            navigator: resolve(navigationController: navigationController),
            productsUseCase: resolve(),
            addToCartUseCase: resolve(),
            currentShoppingCartUseCase: resolve()
        )
    }
}

extension ProductsAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> ProductsNavigatorType {
        return ProductsNavigator(assembler: self, navigationController: navigationController)
    }
    
    func resolve() -> ProductsUseCaseType {
        return ProductsUseCase(productGateway: resolve())
    }
  
}

extension ProductsAssembler where Self: PreviewAssembler {
    func resolve(navigationController: UINavigationController) -> ProductsNavigatorType {
        return ProductsNavigator(assembler: self, navigationController: navigationController)
    }
    
    func resolve() -> ProductsUseCaseType {
        return ProductsUseCase(productGateway: resolve())
    }
    
}
