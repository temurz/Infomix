//
//  ShowingSplash.swift
//  InfoMix
//
//  Created by Damir Asamatdinov on 26/01/22.
//  Copyright © 2022 InfoMix. All rights reserved.
//

import UIKit
import SwiftUI

protocol ShowingSplash {
    var assembler: Assembler { get }
    var navigationController: UINavigationController { get }
}

extension ShowingSplash {
    func showSplash() {
        let lv: SplashView = assembler.resolve(navigationController: navigationController)
        let hvc: UIHostingController = UIHostingController(rootView: lv)
        
        var viewControllers = navigationController.viewControllers
        
        viewControllers.removeAll()
        viewControllers.append(hvc)
        
        navigationController.setViewControllers(viewControllers, animated: true)
    }
}

