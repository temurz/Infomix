//
//  ShowingChangePassword.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 17/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//


import UIKit
import SwiftUI

protocol ShowingChangePassword {
    var assembler: Assembler { get }
    var navigationController: UINavigationController { get }
}

extension ShowingChangePassword {
    func openChangePassword() {
        let view: ChangePasswordView = assembler.resolve(navigationController: navigationController)
        let vc = UIHostingController(rootView: view)
        navigationController.pushViewController(vc, animated: true)
    }
}
