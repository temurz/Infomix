//
//  GettingTransactionType.swift
//  CleanArchitecture
//
//  Created by Temur on 11/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Foundation

protocol GettingTransactionTypes {
    var transactionHistoryGateway : TransactionHistoryGateway { get }
}

extension GettingTransactionTypes {
    func getTransactionTypes() -> Observable<[TransactionType]>{
        return transactionHistoryGateway.getTransactionTypes()
    }
}
