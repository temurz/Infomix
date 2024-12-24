//
//  ShowingStatusView.swift
//  InfoMix
//
//  Created by Temur A. Zaitov on 24/12/24.
//  Copyright © 2024 InfoMix. All rights reserved.
//
import SwiftUI
protocol ShowingStatusView {
    var assembler: Assembler { get }
    var navigationController: UINavigationController { get }
}

extension ShowingStatusView {
    func showStatusView(_ loyalty: Loyalty?) {
        let view: StatusView = assembler.resolve(navigationController: navigationController, loyalty: loyalty)
        let vc = UIHostingController(rootView: view)
        navigationController.pushViewController(vc, animated: true)
    }
}
