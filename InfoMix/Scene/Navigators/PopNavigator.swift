//
//  PopNavigator.swift
//  InfoMix
//
//  Created by Temur A. Zaitov on 20/12/24.
//  Copyright © 2024 InfoMix. All rights reserved.
//

import UIKit
protocol PopNavigator {
    var navigationController: UINavigationController { get }
}

extension PopNavigator {
    func popView() {
        navigationController.popViewController(animated: true)
    }
}
