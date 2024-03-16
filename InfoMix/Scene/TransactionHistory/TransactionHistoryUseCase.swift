//
//  HistoryUseCase.swift
//  CleanArchitecture
//
//  Created by Temur on 12/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Foundation

protocol TransactionHistoryUseCaseType {
    func getTransactionHistory(input: TransactionHistoryInput, page: Int) -> Observable<PagingInfo<Transaction>>
}

struct TransactionHistoryUseCase :  TransactionHistoryUseCaseType, GettingTransaction{
    func getTransactionHistory(input: TransactionHistoryInput, page: Int) -> Observable<PagingInfo<Transaction>> {
        let dto = GetPageDto(page: page, perPage: 10)
        return getTransactionHistory(input: input, dto: dto)
    }
    
    
    let transactionHistoryGateway: TransactionHistoryGateway
    
}

struct TransactionHistoryInput {
    var from : Date
    var to : Date
    var type : String?
}
