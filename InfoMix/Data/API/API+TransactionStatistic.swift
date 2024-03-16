//
//  API+TransactionStatistic.swift
//  CleanArchitecture
//
//  Created by Temur on 18/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Foundation
import Alamofire
import Combine

extension API {
    func getTransactionStatistic(_ input: GetTransactionStatistic) -> Observable<TransactionStatistic>{
        return request(input)
    }
    
    final class GetTransactionStatistic : APIInput {
        init(from: Date,to: Date){
            let params : Parameters = [
                "from" : from.toApiFormat(),
                "to" : to.toApiFormat()
            ]
            
            super.init(urlString: API.Urls.transactionStatistic,
                       parameters: params,
                       method: .post,
                       requireAccessToken: true)
        }
    }
}
