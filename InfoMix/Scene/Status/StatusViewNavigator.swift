//
//  StatusViewNavigator.swift
//  InfoMix
//
//  Created by Temur on 16/12/2024.
//  Copyright © 2024 InfoMix. All rights reserved.
//
import UIKit
protocol StatusViewNavigatorType {
    func popView()
}

struct StatusViewNavigator: StatusViewNavigatorType, PopNavigator {
    var navigationController: UINavigationController
}
