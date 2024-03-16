//
//  ShowingMain.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 10/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import UIKit
import SwiftUI

protocol ShowingMain{
    var assembler: Assembler {get}
    var navigationController: UINavigationController {get}
}

extension ShowingMain{
    
    func showMain(cardConfig: CardConfig) {
        
        let lv: MainView = assembler.resolve(navigationController: navigationController, cardConfig: cardConfig)
        let hvc: UIHostingController = UIHostingController(rootView: lv)
        
        var viewControllers = navigationController.viewControllers
        
        viewControllers.removeAll()
        viewControllers.append(hvc)
        
        navigationController.setViewControllers(viewControllers, animated: true)
    }
    
}
