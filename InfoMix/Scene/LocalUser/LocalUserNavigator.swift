//
//  LocalUserNavigator.swift
//  InfoMix
//
//  Created by Damir Asamatdinov on 25/01/22.
//  Copyright © 2022 InfoMix. All rights reserved.
//

import UIKit

protocol LocalUsersNavigatorType {
    func showMain(cardConfig: CardConfig)
    func showLogin(cardConfig: CardConfig)
}

struct LocalUsersNavigator: LocalUsersNavigatorType, ShowingMain, ShowingLogin {
    func showLogin(cardConfig: CardConfig) {
        self.showLogin(cardConfig: cardConfig, primaryAccount: false)
    }
    
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
}
