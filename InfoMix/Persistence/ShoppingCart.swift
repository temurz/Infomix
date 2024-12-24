//
//  ShoppingCart.swift
//  InfoMix
//
//  Created by Temur A. Zaitov on 21/12/24.
//  Copyright © 2024 InfoMix. All rights reserved.
//

import Foundation
class ShoppingCart {
    static let shared = ShoppingCart()

    private init() {}

    var orderId: Int = 0
}
