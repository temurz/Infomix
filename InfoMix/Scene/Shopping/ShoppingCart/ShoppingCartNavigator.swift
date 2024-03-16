//
//  ShoppingCartNavigator.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 12/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import UIKit
import SwiftUI

protocol ShoppingCartNavigatorType {
    func showProductList()
}

struct ShoppingCartNavigator: ShoppingCartNavigatorType, ShowingProductList {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
}
