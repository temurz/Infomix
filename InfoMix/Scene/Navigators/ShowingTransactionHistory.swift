//
//  File.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 12/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import UIKit
import SwiftUI

protocol ShowingTransactionHistory {
    var assembler: Assembler { get }
    var navigationController: UINavigationController { get }
}

extension ShowingTransactionHistory {
    func showTransactionHistory() {
        let view: TransactionHistoryView = assembler.resolve(navigationController: navigationController)
        let vc = UIHostingController(rootView: view)
        vc.title = "Transaction History"
        navigationController.pushViewController(vc, animated: true)
    }
    
}
