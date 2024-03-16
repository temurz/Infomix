//
//  ShowingRoot.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 29/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import UIKit
import SwiftUI

protocol ShowingRoot{
    var assembler: Assembler {get}
    var navigationController: UINavigationController {get}
}

extension ShowingRoot{
    
    func toRoot() {
        navigationController.popToRootViewController(animated: true)
    }
    
}
