//
//  ChangePasswordAssembler.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 17/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//


import UIKit

protocol ChangePasswordAssembler {
    func resolve(navigationController: UINavigationController) -> ChangePasswordViewModel
    func resolve(navigationController: UINavigationController) -> ChangePasswordView
    func resolve() -> ChangePasswordUseCaseType
    func resolve(navigationController: UINavigationController) -> ChangePasswordNavigatorType
  
}

extension ChangePasswordAssembler {
    
    
    func resolve(navigationController: UINavigationController) -> ChangePasswordView {
        let vm: ChangePasswordViewModel = resolve(navigationController: navigationController)
        let vc = ChangePasswordView(viewModel: vm)
        return vc
    }
    
    func resolve(navigationController: UINavigationController) -> ChangePasswordViewModel {
        return ChangePasswordViewModel(changePasswordUseCase: resolve(), navigator: resolve(navigationController: navigationController))
    }
    
}
extension ChangePasswordAssembler where Self: DefaultAssembler {
    
    func resolve() -> ChangePasswordUseCaseType{
        return ChangePasswordUseCase(authGateway: resolve())
    }
    
    func resolve(navigationController: UINavigationController) -> ChangePasswordNavigatorType {
        return ChangePasswordNavigator(assembler: self, navigationController: navigationController)
    }
   
}

extension ChangePasswordAssembler where Self: PreviewAssembler {
   
    
    func resolve() -> ChangePasswordUseCaseType{
        return ChangePasswordUseCase(authGateway: resolve())
    }
    
    func resolve(navigationController: UINavigationController) -> ChangePasswordNavigatorType {
        return ChangePasswordNavigator(assembler: self, navigationController: navigationController)
    }
}
