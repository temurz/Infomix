//
//  ChangeLanguageAssembler.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 19/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import UIKit

protocol ChangeLanguageAssembler {
    func resolve(navigationController: UINavigationController) -> ChangeLanguageViewModel
    func resolve(navigationController: UINavigationController) -> ChangeLanguageView
    func resolve(navigationController: UINavigationController) -> ChangeLanguageNavigatorType
  
}

extension ChangeLanguageAssembler {
    
    
    func resolve(navigationController: UINavigationController) -> ChangeLanguageView {
        let vm: ChangeLanguageViewModel = resolve(navigationController: navigationController)
        let vc = ChangeLanguageView(viewModel: vm)
        return vc
    }
    
    func resolve(navigationController: UINavigationController) -> ChangeLanguageViewModel {
        return ChangeLanguageViewModel(navigator: resolve(navigationController: navigationController))
    }
    
}
extension ChangeLanguageAssembler where Self: DefaultAssembler {
    
    func resolve(navigationController: UINavigationController) -> ChangeLanguageNavigatorType {
        return ChangeLanguageNavigator(assembler: self, navigationController: navigationController)
    }
   
}

extension ChangeLanguageAssembler where Self: PreviewAssembler {
    
    func resolve(navigationController: UINavigationController) -> ChangeLanguageNavigatorType {
        return ChangeLanguageNavigator(assembler: self, navigationController: navigationController)
    }
}
