//
//  ProductCategoryNavigator.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 07/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import SwiftUI

protocol ProductCategoryNavigatorType{
    func showProductList(category: ProductCategory?)
    func showProductCategoryList(intent: ProductCategoryIntent, filteredCategory: ProductCategory?)
    func showHome()
}

struct ProductCategoryNavigator: ProductCategoryNavigatorType, ShowingProductList, ShowingProductCategoryList {
   
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController

    func showHome() {
        navigationController.popToRootViewController(animated: true)
    }
}
