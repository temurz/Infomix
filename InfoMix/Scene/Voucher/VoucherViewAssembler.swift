//
//  VoucherViewAssembler.swift
//  InfoMix
//
//  Created by Temur on 13/06/2025.
//  Copyright © 2025 InfoMix. All rights reserved.
//

import UIKit

protocol VoucherViewAssembler {
    func resolve(navigationController: UINavigationController) -> VoucherView
    func resolve(navigationController: UINavigationController) -> VoucherViewModel
    func resolve(navigationController: UINavigationController) -> VoucherNavigatorType
    func resolve() -> VoucherViewUseCaseType
}

extension VoucherViewAssembler {
    func resolve(navigationController: UINavigationController) -> VoucherView {
        return VoucherView(viewModel: resolve(navigationController: navigationController))
    }
    
    func resolve(navigationController: UINavigationController) -> VoucherViewModel {
        return VoucherViewModel(navigator: resolve(navigationController: navigationController), useCase: resolve())
    }
}


extension VoucherViewAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> VoucherNavigatorType {
        return VoucherNavigator(assembler: self, navigationController: navigationController)
    }
    
    func resolve() -> VoucherViewUseCaseType {
        return VoucherViewUseCase(voucherGateway: resolve())
    }
}

extension VoucherViewAssembler where Self: PreviewAssembler {
    func resolve(navigationController: UINavigationController) -> VoucherNavigatorType {
        return VoucherNavigator(assembler: self, navigationController: navigationController)
    }
    
    func resolve() -> VoucherViewUseCaseType {
        return VoucherViewUseCase(voucherGateway: resolve())
    }
}
