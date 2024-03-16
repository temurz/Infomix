//
//  SplashAssembler.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 10/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import UIKit

protocol SplashAssembler {
    func resolve(navigationController: UINavigationController) -> SplashViewModel
    func resolve(navigationController: UINavigationController) -> SplashNavigatorType
    func resolve() -> GetCardConfigUseCaseType
}

extension SplashAssembler {
    
    
    func resolve(navigationController: UINavigationController) -> SplashView {
        let vm: SplashViewModel = resolve(navigationController: navigationController)
        let vc = SplashView(viewModel: vm)
        return vc
    }
    
    func resolve(navigationController: UINavigationController) -> SplashViewModel {
        return SplashViewModel(
            navigator: resolve(navigationController: navigationController),
            getCardConfigUseCase: resolve()
        )
    }
}

extension SplashAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> SplashNavigatorType {
        return SplashNavigator(assembler: self, navigationController: navigationController)
    }
    
    func resolve() -> GetCardConfigUseCaseType {
        return GetCardConfigUseCase(cardConfigGateway: resolve())
    }
}

extension SplashAssembler where Self: PreviewAssembler {
    func resolve(navigationController: UINavigationController) -> SplashNavigatorType {
        return SplashNavigator(assembler: self, navigationController: navigationController)
    }
    
    func resolve() -> GetCardConfigUseCaseType {
        return GetCardConfigUseCase(cardConfigGateway: resolve())
    }
}
