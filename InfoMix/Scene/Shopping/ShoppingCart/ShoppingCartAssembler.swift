//
//  ShoppingCartAssembler.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 11/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//


import UIKit

protocol ShoppingCartAssembler {
    func resolve(navigationController: UINavigationController, order: Order) -> ShoppingCartView
    func resolve(navigationController: UINavigationController, order: Order) -> ShoppingCartViewModel
    func resolve(navigationController: UINavigationController) -> ShoppingCartNavigatorType
    func resolve() -> GetOrderUseCaseType
    func resolve() -> UpdateProductEntryUseCaseType
    func resolve() -> DeleteProductEntryUseCaseType
    func resolve() -> ShoppingCartCheckoutUseCaseType
    func resolve() -> ClearShoppingCartUseCaseType
    func resolve() -> CancelOrderUseCaseType
}

extension ShoppingCartAssembler {
    func resolve(navigationController: UINavigationController, order: Order) -> ShoppingCartView {
        return ShoppingCartView(viewModel: resolve(navigationController: navigationController,order: order))
    }
    
    func resolve(navigationController: UINavigationController, order: Order) -> ShoppingCartViewModel {
        return ShoppingCartViewModel(shoppingCart: order, orderUseCase: resolve(), updateProductEntryUseCase: resolve(), deleteProductEntryUseCase: resolve(), checkoutUseCase: resolve(), cancelOrderUseCase: resolve(), clearShoppingCartUseCase: resolve(), navigator: resolve(navigationController: navigationController))
    }
}

extension ShoppingCartAssembler where Self: DefaultAssembler {
    
    func resolve(navigationController: UINavigationController) -> ShoppingCartNavigatorType{
        return ShoppingCartNavigator(assembler: self, navigationController: navigationController)
    }
   
    func resolve() -> UpdateProductEntryUseCaseType {
        return UpdateProductEntryUseCase(shoppingGateway: resolve())
    }
    
     func resolve() -> DeleteProductEntryUseCaseType {
         return DeleteProductEntryUseCase(shoppingGateway: resolve())
     }
   
    
     func resolve() -> ShoppingCartCheckoutUseCaseType {
         return ShoppingCartCheckoutUseCase(shoppingGateway: resolve())
     }
   
    
     func resolve() -> ClearShoppingCartUseCaseType {
         return ClearShoppingCartUseCase(shoppingGateway: resolve())
     }
   
    
     func resolve() -> CancelOrderUseCaseType {
         return CancelOrderUseCase(shoppingGateway: resolve())
     }
    
     func resolve() -> GetOrderUseCaseType {
         return GetOrderUseCase(shoppingGateway: resolve())
     }
  
}

extension ShoppingCartAssembler where Self: PreviewAssembler {
    
    func resolve(navigationController: UINavigationController) -> ShoppingCartNavigatorType{
        return ShoppingCartNavigator(assembler: self, navigationController: navigationController)
    }
    
     func resolve() -> UpdateProductEntryUseCaseType {
         return UpdateProductEntryUseCase(shoppingGateway: resolve())
     }
     
      func resolve() -> DeleteProductEntryUseCaseType {
          return DeleteProductEntryUseCase(shoppingGateway: resolve())
      }
    
     
      func resolve() -> ShoppingCartCheckoutUseCaseType {
          return ShoppingCartCheckoutUseCase(shoppingGateway: resolve())
      }
    
     
      func resolve() -> ClearShoppingCartUseCaseType {
          return ClearShoppingCartUseCase(shoppingGateway: resolve())
      }
    
     
      func resolve() -> CancelOrderUseCaseType {
          return CancelOrderUseCase(shoppingGateway: resolve())
      }
    
     func resolve() -> GetOrderUseCaseType {
         return GetOrderUseCase(shoppingGateway: resolve())
     }
  
}
