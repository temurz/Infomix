//
//  ShowingShoppingCart.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 11/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import UIKit
import SwiftUI

protocol ShowingShoppingCart {
    var assembler: Assembler { get }
    var navigationController: UINavigationController { get }
}

extension ShowingShoppingCart {
    func showShoppingCart(order: Order) {
        let view: ShoppingCartView = assembler.resolve(navigationController: navigationController, order:order)
        let vc = UIHostingController(rootView: view)
        navigationController.pushViewController(vc, animated: true)
    }
}
