//
//  API+City.swift
//  InfoMix
//
//  Created by Temur on 09/03/22.
//  Copyright © 2022 InfoMix. All rights reserved.
//

import Foundation

extension API {
    func getCitiesList(_ input: GetCitiesList) -> Observable<[City]>{
        return requestList(input)
    }
    
    final class GetCitiesList : APIInput{
        init() {
            super.init(urlString: API.Urls.cities,
                       parameters: nil,
                       method: .get,
                       requireAccessToken: true)
        }
    }
}
