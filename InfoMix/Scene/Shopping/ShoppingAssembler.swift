//
//  ShoppingAssembler.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 06/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import UIKit

protocol ShoppingAssembler {
    func resolve(navigationController: UINavigationController, certificate: CertificateItemViewModel) -> ShoppingViewModel
    func resolve(navigationController: UINavigationController, certificate: CertificateItemViewModel) -> ShoppingView
    func resolve(navigationController: UINavigationController) -> ShoppingNavigatorType
    func resolve() -> AddToCartUseCaseType
    func resolve() -> CurrentShoppingCartUseCaseType
    func resolve() -> TopProductListUseCaseType
}

extension ShoppingAssembler {
    
    
    func resolve(navigationController: UINavigationController, certificate: CertificateItemViewModel) -> ShoppingView {
        let vm: ShoppingViewModel = resolve(navigationController: navigationController, certificate: certificate)
        let vc = ShoppingView(viewModel: vm)
        return vc
    }
    
    func resolve(navigationController: UINavigationController, certificate: CertificateItemViewModel) -> ShoppingViewModel {
        return ShoppingViewModel(certificate: certificate, currentShoppingCartUseCase: resolve(), addToCartUseCase: resolve(), topProductListUseCase: resolve(), navigator: resolve(navigationController: navigationController))
    }
    
}
extension ShoppingAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> ShoppingNavigatorType {
        return ShoppingNavigator(assembler: self, navigationController: navigationController)
    }
  
    func resolve() -> CurrentShoppingCartUseCaseType{
        return CurrentShoppingCartUseCase(shoppingGateway: resolve())
    }
    
    func resolve() -> AddToCartUseCaseType{
        return AddToCartUseCase(shoppingGateway: resolve())
    }
    
    func resolve() -> TopProductListUseCaseType{
        return TopProductListUseCase(productGateway: resolve())
    }
}

extension ShoppingAssembler where Self: PreviewAssembler {
    func resolve(navigationController: UINavigationController) -> ShoppingNavigatorType {
        return ShoppingNavigator(assembler: self, navigationController: navigationController)
    }
  
    func resolve() -> CurrentShoppingCartUseCaseType{
        return CurrentShoppingCartUseCase(shoppingGateway: resolve())
    }
    
    func resolve() -> AddToCartUseCaseType{
        return AddToCartUseCase(shoppingGateway: resolve())
    }
    
    func resolve() -> TopProductListUseCaseType{
        return TopProductListUseCase(productGateway: resolve())
    }
  
}
