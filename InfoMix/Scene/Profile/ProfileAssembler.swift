//
//  ShoppingAssembler.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 06/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import UIKit

protocol ProfileAssembler {
    func resolve(navigationController: UINavigationController, certificate: CertificateItemViewModel) -> ProfileViewModel
    func resolve(navigationController: UINavigationController, certificate: CertificateItemViewModel) -> ProfileView
    func resolve(navigationController: UINavigationController) -> ProfileNavigatorType
    func resolve() -> LogoutUseCaseType
  
}

extension ProfileAssembler {
    
    
    func resolve(navigationController: UINavigationController, certificate: CertificateItemViewModel) -> ProfileView {
        let vm: ProfileViewModel = resolve(navigationController: navigationController, certificate: certificate)
        let vc = ProfileView(viewModel: vm)
        return vc
    }
    
    func resolve(navigationController: UINavigationController, certificate: CertificateItemViewModel) -> ProfileViewModel {
        return ProfileViewModel(certificate: certificate, navigator: resolve(navigationController: navigationController), logoutUseCase: resolve())
    }
    
}
extension ProfileAssembler where Self: DefaultAssembler {
    
    func resolve(navigationController: UINavigationController) -> ProfileNavigatorType{
        return ProfileNavigator(assembler: self, navigationController: navigationController)
    }
   
    func resolve() -> LogoutUseCaseType {
        return LogoutUseCase(authGateway: resolve())
    }
}

extension ProfileAssembler where Self: PreviewAssembler {
   
    func resolve(navigationController: UINavigationController) -> ProfileNavigatorType{
        return ProfileNavigator(assembler: self, navigationController: navigationController)
    }
    
     func resolve() -> LogoutUseCaseType {
         return LogoutUseCase(authGateway: resolve())
     }
}
