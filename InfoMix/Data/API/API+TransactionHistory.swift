//
//  API+TransactionHistory.swift
//  CleanArchitecture
//
//  Created by Temur on 11/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Foundation
import Alamofire
import Combine

extension API {
    func getTransactionHistoryList(_ input: GetTransactionHistoryList) -> Observable<[Transaction]>{
        return requestList(input)
    }
    
    final class GetTransactionHistoryList : APIInput {
        init(dto: GetPageDto,from: Date, to: Date, type : String){
            
                
            var params : Parameters = [
                "rows": dto.perPage,
                "page": dto.page,
                "from": from.toApiFormat(),
                "to" : to.toApiFormat()
            ]
            if(!type.isEmpty && type.uppercased() != "ALL"){
                params["transactionType"] = type
            }
            super.init(urlString: API.Urls.transactionHistory,
                       parameters: params,
                       method: .post,
                       requireAccessToken: true)
        }
    }
}
