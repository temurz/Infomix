//
//  TransactionStatistic.swift
//  CleanArchitecture
//
//  Created by Temur on 09/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Foundation

struct TransactionStatistic {
    let coming : Double?
    let expense : Double?
    let date : Date?
}

extension TransactionStatistic : Decodable{
    enum CodingKeys : String, CodingKey {
        case coming = "coming"
        case expense = "expense"
        case date = "date"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        coming = try values.decodeIfPresent(Double.self, forKey: .coming) ?? 0
        expense = try values.decodeIfPresent(Double.self, forKey: .expense) ?? 0
        date = try values.decodeIfPresent(Double.self, forKey: .date)?.toWindowsDate()
    }
    
    init(){
        self.expense = 0
        self.coming = 0
        self.date = Date()
    }
}
