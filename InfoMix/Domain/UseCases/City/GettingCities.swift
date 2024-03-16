//
//  GettingCities.swift.swift
//  InfoMix
//
//  Created by Temur on 09/03/22.
//  Copyright © 2022 InfoMix. All rights reserved.
//

import Foundation

protocol GettingCities {
    var cityGateway : CityGateway { get }
}

extension GettingCities{
    func getCities() -> Observable<[City]>{
        cityGateway.getCities()
    }
}
