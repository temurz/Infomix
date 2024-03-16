//
//  ShowingLanguageSettings.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 19/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//


import UIKit
import SwiftUI

protocol ShowingLanguageSettings {
    var assembler: Assembler { get }
    var navigationController: UINavigationController { get }
}

extension ShowingLanguageSettings {
    func openLanguageSettings() {
        let view: ChangeLanguageView = assembler.resolve(navigationController: navigationController)
        let vc = UIHostingController(rootView: view)
        navigationController.pushViewController(vc, animated: true)
        navigationController.navigationBar.topItem?.backButtonDisplayMode = .minimal
    }
}

