//
//  CityUseCase.swift
//  InfoMix
//
//  Created by Temur on 09/03/22.
//  Copyright © 2022 InfoMix. All rights reserved.
//

import Foundation

protocol CityUseCaseType {
    func getCities() -> Observable<[City]>
}

struct CityUseCase : CityUseCaseType, GettingCities{
    
    var cityGateway: CityGateway
}
