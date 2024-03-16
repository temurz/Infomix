//
//  API+TransactionTypes.swift.swift
//  CleanArchitecture
//
//  Created by Temur on 14/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Foundation
import Alamofire
import Combine

extension API {
    func getTransactionTypeList(_ input: GetTransactionTypeList) -> Observable<[TransactionType]>{
        return requestList(input)
    }
    
    final class GetTransactionTypeList : APIInput {
        init(){
            
            super.init(urlString: API.Urls.transactionTypes,
                       parameters: nil,
                       method: .get,
                       requireAccessToken: true)
        }
    }
}

