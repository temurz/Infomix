//
//  ScannerAssembler.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 05/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//



import UIKit

protocol ScannerAssembler {
    func resolve(navigationController: UINavigationController, onFound: @escaping (_ code: String) -> Void) -> ScannerView
    func resolve(navigationController: UINavigationController, onFound: @escaping (_ code: String) -> Void) -> ScannerViewModel
}

extension ScannerAssembler {
    func resolve(navigationController: UINavigationController, onFound: @escaping (_ code: String) -> Void) -> ScannerView {
        return ScannerView(viewModel: resolve(navigationController: navigationController, onFound: onFound))
    }
    func resolve(navigationController: UINavigationController, onFound: @escaping (_ code: String) -> Void) -> ScannerViewModel {
        return ScannerViewModel(navigationController: navigationController, onFound: onFound)
    }
}

extension ScannerAssembler where Self: DefaultAssembler {
    
}

extension ScannerAssembler where Self: PreviewAssembler {
      
}

