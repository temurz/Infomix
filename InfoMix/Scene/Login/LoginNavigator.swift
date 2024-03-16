//
//  LoginNavigator.swift
//  CleanArchitecture
//
//  Created by Tuan Truong on 7/14/20.
//  Copyright © 2020 Tuan Truong. All rights reserved.
//
import UIKit

protocol LoginNavigatorType {
    func showMainOrBack(cardConfig: CardConfig)
    func showOnlineApplication()
}

struct LoginNavigator: LoginNavigatorType, ShowingMain, ShowingOnlineApplication {
    func showMainOrBack(cardConfig: CardConfig) {
        if navigationController.viewControllers.count == 1 {
            showMain(cardConfig: cardConfig)
        } else {
            navigationController.popViewController(animated: true)
        }
      
    }
    
    func showOnlineApplication() {
        toOnlineApplicationView()
    }
    
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
}
