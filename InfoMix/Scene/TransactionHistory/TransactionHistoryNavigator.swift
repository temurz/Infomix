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
    
}

struct TransactionHistoryNavigator : TransactionHistoryNavigatorType{
    
    
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
    
}
