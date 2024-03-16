//
//  OrderStatus.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 12/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Then

struct OrderStatus {
    let value: String
    let text: String
}


extension OrderStatus: Then, Equatable {
    static func == (lhs: OrderStatus, rhs: OrderStatus) -> Bool {
        return lhs.value == rhs.value
    }
}

extension OrderStatus: Decodable {
    enum CodingKeys: String, CodingKey {
        case valueField, textField
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        value = try values.decodeIfPresent(String.self, forKey: .valueField) ?? ""
        text = try values.decodeIfPresent(String.self, forKey: .textField) ?? ""
    }
}

