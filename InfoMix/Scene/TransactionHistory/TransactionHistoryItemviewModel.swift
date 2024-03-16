//
//  HistoryItemviewModel.swift
//  CleanArchitecture
//
//  Created by Temur on 11/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Foundation

struct TransactionHistoryItemViewModel : Identifiable {
    
    let transactionType : String?
    let id : Int?
    let amount : Int?
    let amountMethod : Int?
    let comment : String?
    let createDate : Date?
    let typeText : String?
    
    init(transaction: Transaction){
        self.transactionType = transaction.transactionType
        self.id = transaction.id
        self.amount = transaction.amount
        self.amountMethod = transaction.amountMethod
        self.comment = transaction.comment
        self.createDate = transaction.createDate
        self.typeText = transaction.typeText
    }
    
}

