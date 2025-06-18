//
//  Event.swift
//  CleanArchitecture
//
//  Created by Temur on 18/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import Then
import Foundation

struct Event{
    
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


extension Event: Then, Equatable {
    static func == (lhs: Event, rhs: Event) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Event: Decodable {
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
            imageUrl = NetworkManager.shared.baseUrl + "/image/event/" + imgUrl
        }else {
            imageUrl = ""
        }
        
        endEventDate = try values.decodeIfPresent(Double.self, forKey: .endEventDate)?.toWindowsDate()
        createDate = try values.decodeIfPresent(Double.self, forKey: .createDate)?.toWindowsDate()
        type = try values.decodeIfPresent(EventType.self, forKey: .type)
        ads = try values.decodeIfPresent(Bool.self, forKey: .ads)
    }
    
    init(id: Int32){
        self.id = id
        self.title = nil
        self.content = nil
        self.ads = nil
        self.createDate = nil
        self.endEventDate = nil
        self.imageUrl = nil
        self.shortDescription = nil
        self.type = nil 
    }
}
