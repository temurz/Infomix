//
//  LoginAssembler.swift
//  CleanArchitecture
//
//  Created by Tuan Truong on 7/14/20.
//  Copyright © 2020 Tuan Truong. All rights reserved.
//

import UIKit

protocol LoginAssembler {
    func resolve(navigationController: UINavigationController, cardConfig: CardConfig) -> LoginView
    func resolve(navigationController: UINavigationController, cardConfig: CardConfig) -> LoginViewModel
    func resolve(navigationController: UINavigationController) -> LoginNavigatorType
    func resolve() -> LoginUseCaseType
}

extension LoginAssembler {
    func resolve(navigationController: UINavigationController, cardConfig: CardConfig) -> LoginView {
        LoginView(viewModel: resolve(navigationController: navigationController, cardConfig: cardConfig))
    }
    
    func resolve(navigationController: UINavigationController, cardConfig: CardConfig) -> LoginViewModel {
        LoginViewModel(
            cardConfig: cardConfig,
            navigator: resolve(navigationController: navigationController),
            useCase: resolve()
        )
    }
}

extension LoginAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> LoginNavigatorType {
        LoginNavigator(assembler: self, navigationController: navigationController)
    }
    
    func resolve() -> LoginUseCaseType {
        LoginUseCase(authGateway: resolve(), cardConfigGateway: CardConfigGateway())
    }
}

extension LoginAssembler where Self: PreviewAssembler {
    func resolve(navigationController: UINavigationController) -> LoginNavigatorType {
        LoginNavigator(assembler: self, navigationController: navigationController)
    }
    
    func resolve() -> LoginUseCaseType {
        LoginUseCase(authGateway: resolve(), cardConfigGateway: CardConfigGateway())
    }
}
