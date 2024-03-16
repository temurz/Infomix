//
//  OrderHistoryAssembler.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 12/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//


import UIKit

protocol OrderHistoryAssembler {
    func resolve(navigationController: UINavigationController) -> OrderHistoryView
    func resolve(navigationController: UINavigationController) -> OrderHistoryViewModel
    func resolve(navigationController: UINavigationController) -> OrderHistoryNavigatorType
    func resolve() -> OrderListUseCaseType
    func resolve() -> OrderStatusListUseCaseType
    
}

extension OrderHistoryAssembler {
    func resolve(navigationController: UINavigationController) -> OrderHistoryView {
        return OrderHistoryView(viewModel: resolve(navigationController: navigationController))
    }
    
    func resolve(navigationController: UINavigationController) -> OrderHistoryViewModel {
        return OrderHistoryViewModel(navigator: resolve(navigationController: navigationController), useCase: resolve(), statusesUseCase: resolve())
    }
}

extension OrderHistoryAssembler where Self: DefaultAssembler {
   
    func resolve() -> OrderListUseCaseType {
        return OrderListUseCase(shoppingGateway: resolve())
    }
    
     func resolve() -> OrderStatusListUseCaseType {
         return OrderStatusListUseCase(shoppingGateway: resolve())
     }
    
    func resolve(navigationController: UINavigationController) -> OrderHistoryNavigatorType{
        return OrderHistoryNavigator(assembler: self, navigationController: navigationController)
    }
   
}

extension OrderHistoryAssembler where Self: PreviewAssembler {
    
    func resolve() -> OrderListUseCaseType {
        return OrderListUseCase(shoppingGateway: resolve())
    }
    
     func resolve() -> OrderStatusListUseCaseType {
         return OrderStatusListUseCase(shoppingGateway: resolve())
     }
    
    func resolve(navigationController: UINavigationController) -> OrderHistoryNavigatorType{
        return OrderHistoryNavigator(assembler: self, navigationController: navigationController)
    }
    
}
