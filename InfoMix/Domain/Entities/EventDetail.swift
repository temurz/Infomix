//
//  EventContent.swift
//  CleanArchitecture
//
//  Created by Temur on 07/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Foundation
import Then

struct EventDetail {
    let id: Int32?
    let title: String?
    let shortDescription: String?
    let content: String?
    let imageUrl : String?
    let endEventDate: Date?
    let createDate: Date?
    let type: EventType?
    let ads: Bool?
    
}


extension EventDetail: Then, Equatable {
    static func == (lhs: EventDetail, rhs: EventDetail) -> Bool {
        return lhs.id == rhs.id
    }
}

extension EventDetail: Decodable {
    enum CodingKeys: String, CodingKey {
        case id="id"
        case title = "title"
        case shortDescription = "shortDescription"
        case content = "content"
        case imageUrl = "imageUrl"
        case endEventDate = "endEventDate"
        case createDate = "createDate"
        case type = "type"
        case ads = "ads"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int32.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        shortDescription = try values.decodeIfPresent(String.self, forKey: .shortDescription)
        content = try values.decodeIfPresent(String.self, forKey: .content)
        
        if let imgUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl){
            imageUrl = "http://airfel.akfa.uz/api/v2/image/event/" + imgUrl
        }else {
            imageUrl = ""
        }
        endEventDate = try values.decodeIfPresent(Date.self, forKey: .endEventDate)
        createDate = try values.decodeIfPresent(Date.self, forKey: .createDate)
        type = try values.decodeIfPresent(EventType.self, forKey: .type)
        ads = try values.decodeIfPresent(Bool.self, forKey: .ads)
    }
}
