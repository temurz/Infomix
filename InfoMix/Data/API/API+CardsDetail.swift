//
//  API+CardDetail.swift
//  InfoMix
//
//  Created by Temur on 26/01/22.
//  Copyright © 2022 InfoMix. All rights reserved.
//

import Foundation

extension API {
    
    func getCardsDetail(_ input: GetCardsDetailInput) -> Observable<SerialCard>{
        return request(input)
        
    }
    
    final class GetCardsDetailInput: APIInput{
        
        init(id: Int){
            
            super.init(urlString: String.init(format: Urls.getCardsDetail, id),
                       parameters: nil,
                       method: .get,
                       requireAccessToken: true)
        }
    }
}
