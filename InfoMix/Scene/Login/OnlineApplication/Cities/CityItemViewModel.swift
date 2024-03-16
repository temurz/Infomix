//
//  CityItemViewModel.swift
//  InfoMix
//
//  Created by Temur on 07/03/22.
//  Copyright © 2022 InfoMix. All rights reserved.
//

import Foundation

struct CityItemViewModel : Identifiable{
    var id : Int
    var cityName : String?
    var child : [City]?
    
    init(city: City){
        self.cityName = city.name
        self.child = city.children
        self.id  = city.id
    }
}
