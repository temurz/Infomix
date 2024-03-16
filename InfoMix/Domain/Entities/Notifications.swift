//
//  Notification.swift
//  CleanArchitecture
//
//  Created by Temur on 22/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Foundation

enum Subject : String {
    case SYSTEM, SCORE, EVENT, ORDER, PRICE, PAYMENT, DISPUTE, PENALTY
}

struct Notifications {
    let id : Int
    let subject: Subject
    let title : String?
    let content : String?
    let createDate : Date?
    let objectId: Int
}

extension Notifications : Decodable {
    
    enum CodingKeys : String, CodingKey {
        case title = "title"
        case content = "content"
        case createDate = "createDate"
        case subject = "subject"
        case id = "id"
        case objectId = "objectId"
    }
    
    init(from decoder: Decoder) throws{
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        content = try values.decodeIfPresent(String.self, forKey: .content)
        createDate = try values.decodeIfPresent(Double.self, forKey: .createDate)?.toWindowsDate()
        subject = Subject.init(rawValue: (try values.decodeIfPresent(String.self, forKey: .subject) ?? "SYSTEM")) ?? Subject.SYSTEM
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? 0
        objectId = try values.decodeIfPresent(Int.self, forKey: .objectId) ?? 0
    }
}
