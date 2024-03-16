//
//  Model.swift
//  InfoMix
//
//  Created by Temur on 26/01/22.
//  Copyright © 2022 InfoMix. All rights reserved.
//

import Foundation

struct Model {
    var id: Int?
    var name: String?
    var barcode: String?
}


extension Model: Decodable{
    
    enum CodingKeys: String,CodingKey{
        case id = "id"
        case name = "name"
        case barcode = "barcode"
    }
    
    init(from decoder: Decoder) throws{
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? 0
        name = try values.decodeIfPresent(String.self, forKey: .name)
        barcode = try values.decodeIfPresent(String.self, forKey: .barcode)
        
    }
}
