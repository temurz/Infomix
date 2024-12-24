//
//  Market.swift
//  InfoMix
//
//  Created by Temur A. Zaitov on 23/12/24.
//  Copyright © 2024 InfoMix. All rights reserved.
//

import Foundation

struct Market : Decodable, Identifiable, Hashable{
    var id : Int
    var name : String?

    static func == (lhs: Market, rhs: Market) -> Bool{
        lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    enum CodingKeys : String, CodingKey{
        case id = "id"
        case name = "name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
    }
}
