//
//  AddCardAssembler.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 22/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import UIKit

protocol AddCardAssembler {
    func resolve(navigationController: UINavigationController,cardConfig: CardConfig) -> AddCardView
    func resolve(navigationController: UINavigationController,cardConfig: CardConfig) -> AddCardViewModel
    func resolve(navigationController: UINavigationController) ->  AddCardNavigatorType
}

extension AddCardAssembler {
    func resolve(navigationController: UINavigationController, cardConfig: CardConfig) -> AddCardView {
        return AddCardView(viewModel: resolve(navigationController: navigationController, cardConfig: cardConfig))
    }
    func resolve(navigationController: UINavigationController, cardConfig: CardConfig) -> AddCardViewModel {
        return AddCardViewModel(cardConfig: cardConfig, navigator: resolve(navigationController: navigationController))
    }
}

extension AddCardAssembler where Self: DefaultAssembler {
    
    func resolve(navigationController: UINavigationController) ->  AddCardNavigatorType{
        return AddCardNavigator(assembler: self, navigationController: navigationController)
        
    }
    
}

extension AddCardAssembler where Self: PreviewAssembler {
    
    func resolve(navigationController: UINavigationController) ->  AddCardNavigatorType{
        return AddCardNavigator(assembler: self, navigationController: navigationController)
    }
   }

