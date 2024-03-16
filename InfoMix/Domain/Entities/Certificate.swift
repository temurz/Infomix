//
//  Certificate.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 10/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//


import Then

struct Certificate {

    var id: Int32?
    var certificate: String?
    var master: Master?
    var service: Job?
    var dailyLimitCard:Int32?
    var unreadNotification: Int32?
    var expired: Bool
    var blocked: Bool
    var needUpgradeConfig: Bool
    
}

extension Certificate: Then, Equatable {
    static func == (lhs: Certificate, rhs: Certificate) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Certificate: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case certificate = "certificate"
        case master = "master"
        case service = "job"
        case unSeenNotificationCount = "unreadNotification"
        case needUpgradeConfig = "TotalRecovered"
        case blocked = "blocked"
        case expired = "expired"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decodeIfPresent(Int32.self, forKey: .id)
        certificate = try values.decodeIfPresent(String.self, forKey: .certificate)
        master = try values.decodeIfPresent(Master.self, forKey: .master)
        service = try values.decodeIfPresent(Job.self, forKey: .service)
        unreadNotification = try values.decodeIfPresent(Int32.self, forKey: .unSeenNotificationCount)
        needUpgradeConfig = try values.decodeIfPresent(Bool.self, forKey: .needUpgradeConfig) ?? false
        blocked = try values.decodeIfPresent(Bool.self, forKey: .blocked) ?? false
        expired = try values.decodeIfPresent(Bool.self, forKey: .expired) ?? false
    }
    
    
}

