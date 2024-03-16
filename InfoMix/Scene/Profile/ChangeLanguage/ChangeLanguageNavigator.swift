//
//  ChangeLanguageNavigator.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 19/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//
import UIKit
import SwiftUI

protocol ChangeLanguageNavigatorType {
    func back()
} 

struct ChangeLanguageNavigator: ChangeLanguageNavigatorType {
    func back() {
        navigationController.popViewController(animated: true)
    }
    
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
}
