//
//  CityGateway.swift
//  InfoMix
//
//  Created by Temur on 09/03/22.
//  Copyright © 2022 InfoMix. All rights reserved.
//

import Foundation
import Combine

protocol CityGatewayType{
    func getCities() -> Observable<[City]>
}

struct CityGateway : CityGatewayType{
    func getCities() -> Observable<[City]> {
        let input = API.GetCitiesList()
        return API.shared.getCitiesList(input)
            .map { (output) -> [City]? in
                return output
            }
            .replaceNil(with: [])
            .eraseToAnyPublisher()
        
    }
}

