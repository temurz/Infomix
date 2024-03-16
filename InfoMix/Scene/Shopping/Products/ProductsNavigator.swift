//
//  ProductsNavigator.swift
//  CleanArchitecture
//
//  Created by Tuan Truong on 7/14/20.
//  Copyright © 2020 Tuan Truong. All rights reserved.
//

import UIKit
import SwiftUI

protocol ProductsNavigatorType {
    func showShoppingCart(order: Order)
    func showProductCategoryList(filteredCategory: ProductCategory?)
}

struct ProductsNavigator: ProductsNavigatorType, ShowingShoppingCart, ShowingProductCategoryList {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
}
