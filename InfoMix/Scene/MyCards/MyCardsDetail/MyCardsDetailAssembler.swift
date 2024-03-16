//
//  MyCardsDetailAssembler.swift
//  InfoMix
//
//  Created by Temur on 26/01/22.
//  Copyright © 2022 InfoMix. All rights reserved.
//

import Foundation
import UIKit

protocol MyCardsDetailAssembler{
    func resolve(navigationController: UINavigationController, serialCard: SerialCard) -> MyCardsDetailView
    func resolve(navigationController: UINavigationController, serialCard: SerialCard) -> MyCardsDetailViewModel
    func resolve() -> MyCardsDetailUseCaseType
}

extension MyCardsDetailAssembler{
    func resolve(navigationController: UINavigationController,serialCard: SerialCard) -> MyCardsDetailView {
        return MyCardsDetailView(viewModel: resolve(navigationController: navigationController, serialCard: serialCard))
    }
                                 
    func resolve(navigationController: UINavigationController, serialCard: SerialCard) -> MyCardsDetailViewModel{
            return MyCardsDetailViewModel(useCase: resolve(), serialCard: serialCard)
        }
}

extension MyCardsDetailAssembler where Self: DefaultAssembler{
    func resolve() -> MyCardsDetailUseCaseType{
        return MyCardsDetailUseCase(myCardsGateway: CardGateway())
    }
}

extension MyCardsDetailAssembler where Self: PreviewAssembler {
    func resolve() -> MyCardsDetailUseCaseType{
        return MyCardsDetailUseCase(myCardsGateway: CardGateway())
    }
}
