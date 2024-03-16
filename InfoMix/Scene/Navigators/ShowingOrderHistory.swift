//
//  ShowingOrderHistory.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 06/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//


import UIKit
import SwiftUI

protocol ShowingOrderHistory {
    var assembler: Assembler { get }
    var navigationController: UINavigationController { get }
}

extension ShowingOrderHistory {
    func showOrderHistory() {
        let view: OrderHistoryView = assembler.resolve(navigationController: navigationController)
        let vc = UIHostingController(rootView: view)
        navigationController.pushViewController(vc, animated: true)
    }
}
