//
//  Master.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 10/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import Then

struct Master{
    
    let id: Int32?
    let firstName: String?
    let fathersName: String?
    let lastName: String?
    let phone: String?
    let birthday: String?
    let status: String?
    
    
    
}


extension Master: Then, Equatable {
    static func == (lhs: Master, rhs: Master) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Master: Decodable {
    enum CodingKeys: String, CodingKey {
        case id="id"
        case firstName = "firstName"
        case fathersName = "fathersName"
        case lastName = "lastName"
        case phone = "phoneNumber"
        case birthday = "birthday"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int32.self, forKey: .id)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        fathersName = try values.decodeIfPresent(String.self, forKey: .fathersName)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        birthday = try values.decodeIfPresent(String.self, forKey: .birthday)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}
