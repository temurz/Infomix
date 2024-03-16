//
//  City.swift
//  InfoMix
//
//  Created by Temur on 09/03/22.
//  Copyright © 2022 InfoMix. All rights reserved.
//

import Foundation

class City :Decodable, Identifiable, Hashable {
    
    
    
    var id : Int
    var name: String?
    var children: [City]?
    
    static func == (lhs: City, rhs: City) -> Bool {
        lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
    enum CodingKeys : String, CodingKey{
        case id = "id"
        case name = "name"
        case children = "children"
    }

    required init(from decoder: Decoder) throws {
    
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self,forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        children = try values.decodeIfPresent([City].self, forKey: .children)
    }
    
    init() {
        id = 1
        name = ""
        children = nil
    }
}

