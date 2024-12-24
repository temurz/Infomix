//
//  OrderHistoryNavigation.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 12/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//


import UIKit

protocol OrderHistoryNavigatorType {
    func showShoppingCart(order: Order)
    func popView()
}

struct OrderHistoryNavigator: OrderHistoryNavigatorType, ShowingShoppingCart, PopNavigator {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
    
}
