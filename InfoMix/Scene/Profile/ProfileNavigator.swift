
//
//  ProfileNavigator.swift
//  CleanArchitecture
//
//  Created by Tuan Truong on 7/14/20.
//  Copyright © 2020 Tuan Truong. All rights reserved.
//

import UIKit
import SwiftUI

protocol ProfileNavigatorType {
    func openChangePassword()
    func openLanguageSettings()
    func openAbout()
    func showLogin(cardConfig: CardConfig)
    func showLocalUsers(cardConfig: CardConfig)
    func showSplash()
}

struct ProfileNavigator: ProfileNavigatorType, ShowingChangePassword, ShowingLogin, ShowingLanguageSettings, ShowingAbout, ShowingLocalUsers, ShowingSplash{
   
    func showLocalUsers(cardConfig: CardConfig) {
        self.showLocalUsers(cardConfig: cardConfig, forceActiveUser: true)
    }
    
    func showLogin(cardConfig: CardConfig) {
        self.showLogin(cardConfig: cardConfig, primaryAccount: true)
    }
    
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
    
    
}
