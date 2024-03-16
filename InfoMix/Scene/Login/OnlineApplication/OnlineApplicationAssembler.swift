//
//  OnlineApplicationAssembler.swift
//  InfoMix
//
//  Created by Temur on 07/03/22.
//  Copyright © 2022 InfoMix. All rights reserved.
//

import Foundation
import UIKit

protocol OnlineApplicationAssembler{
    func resolve(navigationController: UINavigationController) -> OnlineApplicationView
    func resolve(navigationController: UINavigationController) -> OnlineApplicationViewModel
    func resolve() -> OnlineApplicationUseCaseType
}

extension OnlineApplicationAssembler{
    func resolve(navigationController: UINavigationController) -> OnlineApplicationView{
        return OnlineApplicationView(viewModel: resolve(navigationController: navigationController))
    }
    
    func resolve(navigationController: UINavigationController) -> OnlineApplicationViewModel{
        return OnlineApplicationViewModel(useCase: resolve())
    }
    
}

extension OnlineApplicationAssembler where Self: DefaultAssembler{
    func resolve() -> OnlineApplicationUseCaseType{
        return OnlineApplicationUseCase(cardConfigGateway: CardConfigGateway(), cityGateway: CityGateway())
    }
}

extension OnlineApplicationAssembler where Self: PreviewAssembler{
    func resolve() -> OnlineApplicationUseCaseType {
        return OnlineApplicationUseCase(cardConfigGateway: CardConfigGateway(), cityGateway: CityGateway())
    }
}
