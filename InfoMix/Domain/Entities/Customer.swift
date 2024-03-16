//
//  Customer.swift
//  InfoMix
//
//  Created by Temur on 27/01/22.
//  Copyright © 2022 InfoMix. All rights reserved.
//

import Foundation

struct Customer{
    var phone: String?
    
}

extension Customer: Decodable{
    
    enum CodingKeys: String, CodingKey{
        case phone = "phone"
    }
    
    init(from decoder: Decoder)throws{
        let values = try decoder.container(keyedBy: CodingKeys.self)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
    }
}
