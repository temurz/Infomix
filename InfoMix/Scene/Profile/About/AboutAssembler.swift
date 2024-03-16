//
//  AboutAssembler.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 19/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//


import UIKit

protocol AboutAssembler {
    func resolve(navigationController: UINavigationController) -> AboutViewModel
    func resolve(navigationController: UINavigationController) -> AboutView
  
}

extension AboutAssembler {
    
    
    func resolve(navigationController: UINavigationController) -> AboutView {
        let vm: AboutViewModel = resolve(navigationController: navigationController)
        let vc = AboutView(viewModel: vm)
        return vc
    }
    
    func resolve(navigationController: UINavigationController) -> AboutViewModel {
        return AboutViewModel()
    }
    
}
extension AboutAssembler where Self: DefaultAssembler {
    
}

extension AboutAssembler where Self: PreviewAssembler {
  
}
