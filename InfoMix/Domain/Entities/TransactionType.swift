//
//  TransactionType.swift
//  CleanArchitecture
//
//  Created by Temur on 09/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Foundation

struct TransactionType : Hashable{
    let textField : String
    let valueField : String
}


extension TransactionType: Decodable {
    enum CodingKeys: String, CodingKey {
        case textField = "textField"
        case valueField = "valueField"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        textField = try values.decodeIfPresent(String.self, forKey: .textField) ?? ""
        valueField = try values.decodeIfPresent(String.self, forKey: .valueField) ?? ""
    }
}
