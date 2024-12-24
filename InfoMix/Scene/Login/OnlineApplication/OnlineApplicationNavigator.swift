//
//  OnlineApplicationNavigator.swift
//  InfoMix
//
//  Created by Temur A. Zaitov on 23/12/24.
//  Copyright © 2024 InfoMix. All rights reserved.
//

import UIKit
protocol OnlineApplicationNavigatorType {
    func popView()
}

struct OnlineApplicationNavigator: OnlineApplicationNavigatorType, PopNavigator {
    var navigationController: UINavigationController
}
