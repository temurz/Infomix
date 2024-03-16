//
//  GettingTransaction.swift
//  CleanArchitecture
//
//  Created by Temur on 12/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Foundation

protocol GettingTransaction{
    var transactionHistoryGateway : TransactionHistoryGateway { get }
}

extension GettingTransaction{
    func getTransactionHistory(input: TransactionHistoryInput, dto: GetPageDto) -> Observable<PagingInfo<Transaction>>{
        transactionHistoryGateway.getTransactionHistory(dto: dto, from: input.from, to: input.to, type: input.type ?? "")
    }
}
