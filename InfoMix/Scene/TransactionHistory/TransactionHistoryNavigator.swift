//
//  TransactionHistoryNavigator.swift.swift
//  CleanArchitecture
//
//  Created by Temur on 13/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Foundation
import UIKit

protocol TransactionHistoryNavigatorType {
    func popView()
}

struct TransactionHistoryNavigator : TransactionHistoryNavigatorType, PopNavigator {
    
    
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
    
}
