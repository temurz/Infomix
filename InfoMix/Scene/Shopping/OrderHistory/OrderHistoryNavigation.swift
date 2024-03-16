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
}

struct OrderHistoryNavigator: OrderHistoryNavigatorType, ShowingShoppingCart {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
    
}
