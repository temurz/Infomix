//
//  TransactionStatisticUseCase.swift
//  CleanArchitecture
//
//  Created by Temur on 18/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Foundation

protocol TransactionStatisticUseCaseType {
    func getTransactionStatistic(input: TransactionStatisticInput) -> Observable<TransactionStatistic>
}

struct TransactionStatisticUseCase : TransactionStatisticUseCaseType, GettingTransactionStatistic{    
    var transactionHistoryGateway: TransactionHistoryGateway
}

struct TransactionStatisticInput{
    var from : Date
    var to : Date
}
