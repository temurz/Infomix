//
//  ShowingVoucherView.swift
//  InfoMix
//
//  Created by Temur on 16/06/2025.
//  Copyright © 2025 InfoMix. All rights reserved.
//

import SwiftUI
protocol ShowingVoucherView {
    var assembler: Assembler { get }
    var navigationController: UINavigationController { get }
}

extension ShowingVoucherView {
    func showVoucherView() {
        let view: VoucherView = assembler.resolve(navigationController: navigationController)
        let vc = UIHostingController(rootView: view)
        navigationController.pushViewController(vc, animated: true)
    }
}
