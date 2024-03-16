//
//  ShowingExchange.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 12/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import UIKit
import SwiftUI

protocol ShowingExchange{
    var assembler: Assembler { get }
    var navigationController: UINavigationController {get}
}

extension ShowingExchange{
    func showExchange(){
        let view: ScannerView = assembler.resolve(navigationController:navigationController, onFound: {
            code in 
        })
        let vc = UIHostingController(rootView: view)
        vc.title = "Login"
        navigationController.pushViewController(vc, animated: true)
    }
}
