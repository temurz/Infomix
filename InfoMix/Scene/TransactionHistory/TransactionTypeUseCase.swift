//
//  TransactionTypeUseCase.swift
//  CleanArchitecture
//
//  Created by Temur on 14/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Foundation

protocol TransactionTypeUseCaseType {
    func getTransactionTypes() -> Observable<[TransactionType]>
}

struct TransactionTypeUseCase : TransactionTypeUseCaseType, GettingTransactionTypes {
    var transactionHistoryGateway: TransactionHistoryGateway
}
