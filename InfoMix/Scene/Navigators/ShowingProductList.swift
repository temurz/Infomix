//
//  ShowingProductList.swift
//  CleanArchitecture
//
//  Created by Tuan Truong on 7/29/20.
//  Copyright © 2020 Tuan Truong. All rights reserved.
//

import UIKit
import SwiftUI

protocol ShowingProductList {
    var assembler: Assembler { get }
    var navigationController: UINavigationController { get }
}

extension ShowingProductList {
    func showProductList(category: ProductCategory?) {
        let view: ProductsView = assembler.resolve(navigationController: navigationController, category: category)
        let vc = UIHostingController(rootView: view)
        vc.title = "Product List"
    
        var viewControllers = navigationController.viewControllers

        if viewControllers.count > 1 {
            viewControllers.removeSubrange(1...viewControllers.count-1)
        }
        viewControllers.append(vc)
        
        navigationController.setViewControllers(viewControllers, animated:  true)
    }
    
    func showProductList(){
        self.showProductList(category: nil)
    }
}
