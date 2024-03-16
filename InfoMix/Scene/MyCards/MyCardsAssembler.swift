//
//  NotificationsAssembler.swift
//  CleanArchitecture
//
//  Created by Temur on 22/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Foundation
import UIKit

protocol MyCardsAssembler {
    
    func resolve(navigationController: UINavigationController) -> MyCardsView
    func resolve(navigationController: UINavigationController) -> MyCardsViewModel
    func resolve(navigationController: UINavigationController) -> MyCardsNavigatorType
    func resolve() -> MyCardsUseCaseType
}

extension MyCardsAssembler {
    func resolve(navigationController: UINavigationController) -> MyCardsView{
        return MyCardsView(viewModel: resolve(navigationController: navigationController))
    }

    
    func resolve(navigationController: UINavigationController) -> MyCardsViewModel {
        return MyCardsViewModel(useCase: resolve(), navigator: resolve(navigationController: navigationController))
    }
}

extension MyCardsAssembler where Self: DefaultAssembler{
    func resolve(navigationController: UINavigationController) -> MyCardsNavigatorType{
        return MyCardsNavigator(assembler: self, navigationController: navigationController)
    }
    
    func resolve() -> MyCardsUseCaseType {
        return MyCardsUseCase(cardGateway: CardGateway())
    }
    
}

extension MyCardsAssembler where Self: PreviewAssembler {
    func resolve(navigationController: UINavigationController) -> MyCardsNavigatorType{
        return MyCardsNavigator(assembler: self, navigationController: navigationController)
    }
    
    func resolve() -> MyCardsUseCaseType {
        return MyCardsUseCase(cardGateway: CardGateway())
    }
}
