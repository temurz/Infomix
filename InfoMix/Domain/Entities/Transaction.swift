//
//  Transaction.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 24/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import Foundation

struct Transaction{
    let id: Int
    let transactionType : String?
    let amount : Int?
    let amountMethod : Int?
    let comment : String?
    let createDate : Date?
    let typeText : String?
}

extension Transaction: Decodable {
    enum CodingKeys: String, CodingKey{
        case id = "id"
        case transactionType = "transactionType"
        case amount = "amount"
        case amountMethod = "amountMethod"
        case comment = "comment"
        case createDate = "createDate"
        case typeText = "typeText"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? 0
        transactionType = try values.decodeIfPresent(String.self,forKey: .transactionType)
        amount = try values.decodeIfPresent(Int.self, forKey: .amount)
        amountMethod = try values.decodeIfPresent(Int.self, forKey: .amountMethod)
        comment = try values.decodeIfPresent(String.self, forKey: .comment)
        createDate = try values.decodeIfPresent(Double.self, forKey: .createDate)?.toWindowsDate()
        typeText = try values.decodeIfPresent(String.self, forKey: .typeText)
    }
}
