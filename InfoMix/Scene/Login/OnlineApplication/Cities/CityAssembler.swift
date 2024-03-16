//
//  CityAssembler.swift.swift
//  InfoMix
//
//  Created by Temur on 09/03/22.
//  Copyright © 2022 InfoMix. All rights reserved.
//

import Foundation
import UIKit

protocol CityAssembler{
    func resolve(navigationController: UINavigationController) -> CitiesView
    func resolve(navigationController: UINavigationController) -> CityViewModel
    func resolve() -> CityUseCaseType
}

extension CityAssembler{
    func resolve(navigationController: UINavigationController)-> CitiesView{
        return resolve(navigationController: navigationController)
    }
    
    func resolve(navigationController: UINavigationController) -> CityViewModel{
        return resolve(navigationController: navigationController)
    }
}

extension CityAssembler where Self: DefaultAssembler{
    func resolve() -> CityUseCaseType{
        return CityUseCase(cityGateway: CityGateway())
    }
}

extension CityAssembler where Self: PreviewAssembler{
    func resolve() -> CityUseCaseType{
        return CityUseCase(cityGateway: CityGateway())
    }
}
