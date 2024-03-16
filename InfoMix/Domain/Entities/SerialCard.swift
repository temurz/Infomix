//
//  SerialCard.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 24/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//


import Then
import Foundation

struct SerialCard{
    
    let id: Int
    let status: String?
    let serialNumbers: [SerialNumber]?
    let createDate: Date?
    let modifyDate: Date?
    let customer: Customer?
    
}


extension SerialCard: Then, Equatable {
    static func == (lhs: SerialCard, rhs: SerialCard) -> Bool {
        return lhs.id == rhs.id
    }
}

extension SerialCard: Decodable {
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case status = "status"
        case serialNumbers = "serialNumbers"
        case createDate = "createDate"
        case modifyDate = "modifyDate"
        case customer = "customer"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? 0
        status = try values.decodeIfPresent(String.self, forKey: .status)
        serialNumbers = try values.decodeIfPresent([SerialNumber].self, forKey: .serialNumbers)
        createDate = try values.decodeIfPresent(Double.self, forKey: .createDate)?.toWindowsDate()
        modifyDate = try values.decodeIfPresent(Double.self, forKey: .modifyDate)?.toWindowsDate()
        customer = try values.decodeIfPresent(Customer.self, forKey: .customer)
    }
}

