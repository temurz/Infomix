//
//  ShowingLocalUsers.swift
//  InfoMix
//
//  Created by Damir Asamatdinov on 25/01/22.
//  Copyright © 2022 InfoMix. All rights reserved.
//


import UIKit
import SwiftUI

protocol ShowingLocalUsers {
    var assembler: Assembler { get }
    var navigationController: UINavigationController { get }
}

extension ShowingLocalUsers {
    func showLocalUsers(cardConfig: CardConfig, forceActiveUser: Bool = false) {
        let view: LocalUsersView = assembler.resolve(navigationController: navigationController, cardConfig: cardConfig)
        let vc = UIHostingController(rootView: view)
        
        var viewControllers = navigationController.viewControllers
        
        if forceActiveUser {
            viewControllers.removeAll()
        }
        
        viewControllers.append(vc)
        navigationController.setViewControllers(viewControllers, animated: true)
        
    }
    
}
