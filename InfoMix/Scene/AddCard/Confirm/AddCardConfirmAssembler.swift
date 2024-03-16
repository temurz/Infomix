//
//  ConfirmAssembler.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 23/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import UIKit

protocol AddCardConfirmAssembler {
    func resolve(navigationController: UINavigationController,cardConfig: CardConfig) -> AddCardConfirmView
    func resolve(navigationController: UINavigationController,cardConfig: CardConfig) -> AddCardConfirmViewModel
}

extension AddCardConfirmAssembler {
    func resolve(navigationController: UINavigationController, cardConfig: CardConfig) -> AddCardConfirmView {
        return AddCardConfirmView(viewModel: resolve(navigationController: navigationController, cardConfig: cardConfig))
    }
    func resolve(navigationController: UINavigationController, cardConfig: CardConfig) -> AddCardConfirmViewModel {
        return AddCardConfirmViewModel(cardConfig: cardConfig)
    }
}

extension AddCardConfirmAssembler where Self: DefaultAssembler {
    }

extension AddCardConfirmAssembler where Self: PreviewAssembler {
   }

