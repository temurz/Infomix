//
//  ShowingProductCategories.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 06/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import UIKit
import SwiftUI

protocol ShowingProductCategoryList{
    var assembler: Assembler { get }
    var navigationController: UINavigationController { get }
}

extension ShowingProductCategoryList {
    func showProductCategoryList(intent: ProductCategoryIntent, filteredCategory: ProductCategory?) {
       
        let view: ProductCategoryView = assembler.resolve(navigationController: navigationController, intent: intent, filteredCategory: filteredCategory)
        let vc = UIHostingController(rootView: view)
        if filteredCategory != nil {
            vc.title = "Choose category"
        } else {
            vc.title = "Shop by department"
        }
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showProductCategoryList() {
        showProductCategoryList(intent: ProductCategoryIntent(), filteredCategory: nil)
    }
    
    func showProductCategoryList(filteredCategory: ProductCategory?) {
        showProductCategoryList(intent: filteredCategory?.intent ?? ProductCategoryIntent(), filteredCategory: filteredCategory)
    }
}
