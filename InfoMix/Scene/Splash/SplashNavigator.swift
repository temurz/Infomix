//
//  SplashNavigator.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 09/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//
import UIKit
import SwiftUI

protocol SplashNavigatorType {
    func showMain(cardConfig: CardConfig)
    func showLogin(cardConfig: CardConfig)
    func showLocalUsers(cardConfig: CardConfig)
}

struct SplashNavigator: SplashNavigatorType, ShowingMain, ShowingLogin, ShowingLocalUsers {
    func showLocalUsers(cardConfig: CardConfig) {
        self.showLocalUsers(cardConfig: cardConfig, forceActiveUser: true)
    }
    
   
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
    
    func showLogin(cardConfig: CardConfig) {
        self.showLogin(cardConfig: cardConfig, primaryAccount: true)
    }
    
}
