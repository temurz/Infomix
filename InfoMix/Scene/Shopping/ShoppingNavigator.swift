//
//  ShoppingNavigator.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 06/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import SwiftUI

protocol ShoppingNavigatorType{
    func showProductCategoryList()
    func showProductList()
    func showOrderHistory()
    func showShoppingCart(order: Order)
}

struct ShoppingNavigator: ShoppingNavigatorType, ShowingProductCategoryList, ShowingProductList, ShowingOrderHistory, ShowingShoppingCart {
   
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController

}

