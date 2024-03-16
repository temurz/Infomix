//
//  API+GetCardsHistoryList.swift
//  InfoMix
//
//  Created by Temur on 25/01/22.
//  Copyright © 2022 InfoMix. All rights reserved.
//

import Foundation
import Alamofire

extension API{
    
    func getCardsHistoryList(_ input: GetCardsHistoryInput) -> Observable<[SerialCard]> {
        return requestList(input)
    }
    
    final class GetCardsHistoryInput : APIInput {
        init(dto: GetPageDto){
            let params : Parameters = [
                "rows": dto.perPage,
                "page": dto.page
            ]
            super.init(urlString: API.Urls.getCardsHistory,
                       parameters: params,
                       method: .post,
                       requireAccessToken: true)
        }
    }
}
