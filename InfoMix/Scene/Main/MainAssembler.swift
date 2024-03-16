//
//  HomeAssembler.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 11/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import UIKit

protocol MainAssembler {
    func resolve(navigationController: UINavigationController, cardConfig: CardConfig) -> MainViewRouter
    func resolve(navigationController: UINavigationController, cardConfig: CardConfig) -> MainView
}

extension MainAssembler {
    
    
    func resolve(navigationController: UINavigationController, cardConfig: CardConfig) -> MainView {
        let vm: MainViewRouter = resolve(navigationController: navigationController,cardConfig: cardConfig)
        let vc = MainView(viewRouter: vm)
        return vc
    }
    
}

extension MainAssembler where Self: DefaultAssembler {
    
    func resolve(navigationController: UINavigationController, cardConfig: CardConfig) -> MainViewRouter {
        return MainViewRouter(assembler: self, navigationController: navigationController,cardConfig: cardConfig)
    }
  
}

extension MainAssembler where Self: PreviewAssembler {
    
    func resolve(navigationController: UINavigationController, cardConfig: CardConfig) -> MainViewRouter {
        return MainViewRouter(assembler: self, navigationController: navigationController,cardConfig: cardConfig)
    }
  
}
