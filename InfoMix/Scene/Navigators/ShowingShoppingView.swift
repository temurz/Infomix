//
//  ShowingShoppingView.swift
//  InfoMix
//
//  Created by Temur A. Zaitov on 20/12/24.
//  Copyright © 2024 InfoMix. All rights reserved.
//

import SwiftUI
import Localize_Swift
protocol ShowingShoppingView {
    var assembler: Assembler { get }
    var navigationController: UINavigationController { get }
}

extension ShowingShoppingView {
    func showShoppingView(certificate: CertificateItemViewModel) {
        let view: ShoppingView = assembler.resolve(navigationController: navigationController, certificate: certificate)
        let vc: UIHostingController = UIHostingController(rootView: view)
//        navigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController.pushViewController(vc, animated: true)
    }
}
