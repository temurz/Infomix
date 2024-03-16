//
//  SerialNumber.swift
//  InfoMix
//
//  Created by Temur on 26/01/22.
//  Copyright © 2022 InfoMix. All rights reserved.
//

import Foundation

struct SerialNumber {
    var id: Int
    var serialNumber: String?
    var model: Model?
}

extension SerialNumber : Decodable{
    
    enum CodingKeys: String,CodingKey{
        case id = "id"
        case serialNumber = "serialNumber"
        case model = "model"
    }
        
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? 0
        serialNumber = try values.decodeIfPresent(String.self, forKey: .serialNumber) 
        model = try values.decodeIfPresent(Model.self, forKey: .model)
    }
}
