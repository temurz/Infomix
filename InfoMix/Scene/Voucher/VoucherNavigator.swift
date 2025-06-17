//
//  VoucherNavigator.swift
//  InfoMix
//
//  Created by Temur on 13/06/2025.
//  Copyright © 2025 InfoMix. All rights reserved.
//

import SwiftUI

protocol VoucherNavigatorType {
    func popView()
}

struct VoucherNavigator: VoucherNavigatorType, PopNavigator {
    

    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
}
