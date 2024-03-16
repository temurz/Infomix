//
//  TransactionAssembler.swift
//  CleanArchitecture
//
//  Created by Temur on 08/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Foundation
import UIKit

protocol TransactionHistoryAssembler {
    
    func resolve(navigationController: UINavigationController) -> TransactionHistoryView
    func resolve(navigationController: UINavigationController) -> TransactionHistoryViewModel
    func resolve(navigationController: UINavigationController) -> TransactionHistoryNavigatorType
    func resolve() -> TransactionHistoryUseCaseType
    func resolve() -> TransactionTypeUseCaseType
    func resolve() -> TransactionStatisticUseCaseType
    
}

extension TransactionHistoryAssembler {
    func resolve(navigationController: UINavigationController) -> TransactionHistoryView {
        return TransactionHistoryView(viewModel: resolve(navigationController: navigationController))
    }
    func resolve(navigationController: UINavigationController) -> TransactionHistoryViewModel{
        return TransactionHistoryViewModel(useCase: resolve(), typesUseCase: resolve(), statisticUseCase: resolve(), navigator: resolve(navigationController: navigationController))
    }
}

extension TransactionHistoryAssembler where Self: DefaultAssembler{
    
    func resolve() -> TransactionHistoryUseCaseType{
        return TransactionHistoryUseCase(transactionHistoryGateway: TransactionHistoryGateway())
    }
    func resolve() -> TransactionTypeUseCaseType {
        return TransactionTypeUseCase(transactionHistoryGateway: TransactionHistoryGateway())
    }
    func resolve() -> TransactionStatisticUseCaseType {
        return TransactionStatisticUseCase(transactionHistoryGateway: TransactionHistoryGateway())
    }
    func resolve(navigationController: UINavigationController) -> TransactionHistoryNavigatorType{
        return TransactionHistoryNavigator(assembler: self, navigationController: navigationController)
    }
    
}
extension TransactionHistoryAssembler where Self: PreviewAssembler {
    func resolve() -> TransactionHistoryUseCaseType{
        return TransactionHistoryUseCase(transactionHistoryGateway: TransactionHistoryGateway())
    }
    func resolve() -> TransactionTypeUseCaseType {
        return TransactionTypeUseCase(transactionHistoryGateway: TransactionHistoryGateway())
    }
    func resolve() -> TransactionStatisticUseCaseType {
        return TransactionStatisticUseCase(transactionHistoryGateway: TransactionHistoryGateway())
    }
    func resolve(navigationController: UINavigationController) -> TransactionHistoryNavigatorType{
        return TransactionHistoryNavigator(assembler: self, navigationController: navigationController)
    }
}
