//
//  ICU.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 14/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//


struct ICU{
    let balance: Double
}

extension ICU : Decodable{
    enum CodingKeys: String, CodingKey {
        case balance
    }
    

    init(from decoder: Decoder) throws {	
        let values = try decoder.container(keyedBy: CodingKeys.self)
        balance = try values.decodeIfPresent(Double.self, forKey: .balance) ?? 0.0
    }
    
}
