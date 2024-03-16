//
//  ShowingAbout.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 19/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//


import UIKit
import SwiftUI

protocol ShowingAbout {
    var assembler: Assembler { get }
    var navigationController: UINavigationController { get }
}

extension ShowingAbout {
    func openAbout() {
        let view: AboutView = assembler.resolve(navigationController: navigationController)
        let vc = UIHostingController(rootView: view)
        navigationController.pushViewController(vc, animated: true)
    }
}

