//
//  GettingTransactionStatistic.swift
//  CleanArchitecture
//
//  Created by Temur on 18/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Foundation

protocol GettingTransactionStatistic {
    var transactionHistoryGateway : TransactionHistoryGateway { get }
}
extension GettingTransactionStatistic {
    func getTransactionStatistic(input: TransactionStatisticInput) -> Observable<TransactionStatistic>{
        return transactionHistoryGateway.getTransactionStatistic(from: input.from, to: input.to)
    }
}
