//
//  LocalUsersAssembler.swift
//  InfoMix
//
//  Created by Damir Asamatdinov on 25/01/22.
//  Copyright © 2022 InfoMix. All rights reserved.
//


import UIKit

protocol LocalUsersAssembler {
    func resolve(navigationController: UINavigationController, cardConfig: CardConfig) -> LocalUsersView
    func resolve(navigationController: UINavigationController, cardConfig: CardConfig) -> LocalUsersViewModel
    func resolve(navigationController: UINavigationController) -> LocalUsersNavigatorType
    func resolve() -> GetLocalUsersUseCaseType
}

extension LocalUsersAssembler {
    func resolve(navigationController: UINavigationController, cardConfig: CardConfig) -> LocalUsersView {
        return LocalUsersView(viewModel: resolve(navigationController: navigationController, cardConfig: cardConfig))
    }
    
    func resolve(navigationController: UINavigationController, cardConfig: CardConfig) -> LocalUsersViewModel {
        return LocalUsersViewModel(navigator: resolve(navigationController: navigationController), getLocalUsersUseCase: resolve(),cardConfig: cardConfig)
    }
}

extension LocalUsersAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> LocalUsersNavigatorType {
        return LocalUsersNavigator(assembler: self, navigationController: navigationController)
    }
    
    func resolve() -> GetLocalUsersUseCaseType {
        return GetLocalUsersUseCase(localUserGateway: resolve())
    }
}

extension LocalUsersAssembler where Self: PreviewAssembler {
    func resolve(navigationController: UINavigationController) -> LocalUsersNavigatorType {
        return LocalUsersNavigator(assembler: self, navigationController: navigationController)
    }
    
    func resolve() -> GetLocalUsersUseCaseType {
        return GetLocalUsersUseCase(localUserGateway: resolve())
    }
}
