//
//  ShowingScanner.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 15/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//



import UIKit
import SwiftUI

protocol ShowingScanner{
    var assembler: Assembler { get }
    var navigationController: UINavigationController {get}
}

extension ShowingScanner{
    func showScanner(onFound: @escaping (_ product: SerialNumberedProduct?)->Void) {
        let view: ScannerView = assembler.resolve(navigationController:navigationController, onFound: onFound)
        let vc = UIHostingController(rootView: view)
        vc.modalPresentationStyle = .fullScreen
        navigationController.topViewController?.present(vc, animated: true)
    }
}
