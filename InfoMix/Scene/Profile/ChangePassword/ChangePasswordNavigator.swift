//
//  ChangePasswordNavigator.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 17/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//
import UIKit
import SwiftUI

protocol ChangePasswordNavigatorType {
    func back()
}

struct ChangePasswordNavigator: ChangePasswordNavigatorType {
    func back() {
        navigationController.popViewController(animated: true)
    }
    
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
}
