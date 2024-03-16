//
//  Job.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 10/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import Then

struct Job{
    let id: Int32?
    let name: String?
    let icon: String?
    
  
}

extension Job: Then, Equatable{
    static func == (lhs: Job, rhs: Job) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Job: Decodable{
    enum CodingKeys: String, CodingKey {
        case id="id"
        case name = "name"
        case icon = "icon"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int32.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        icon = try values.decodeIfPresent(String.self, forKey: .icon)
    }
}
