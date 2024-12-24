//
//  Loyalty.swift
//  InfoMix
//
//  Created by Temur on 09/12/2024.
//  Copyright © 2024 InfoMix. All rights reserved.
//

import Foundation
class Loyalty: Decodable {
    let id: Int?
    let createDate : Int?
    let name : String?
    let description : String?
    let targetCount : Int?
    let amount : Double?
    let isFixed : Bool?
    let jobId : Int??
    let backgroundColor : String?
    var icon : String?
    let nextLevel: Loyalty?
    let discount: Double?

    init(id: Int?, createDate: Int?, name: String?, description: String?, targetCount: Int?, amount: Double?, isFixed: Bool?, jobId: Int?, backgroundColor: String?, icon: String?, nextLevel: Loyalty?, discount: Double?) {
        self.id = id
        self.createDate = createDate
        self.name = name
        self.description = description
        self.targetCount = targetCount
        self.amount = amount
        self.isFixed = isFixed
        self.jobId = jobId
        self.backgroundColor = backgroundColor
        self.icon = icon
        self.nextLevel = nextLevel
        self.discount = discount
    }

    enum CodingKeys: CodingKey {
        case id
        case createDate
        case name
        case description
        case targetCount
        case amount
        case isFixed
        case jobId
        case backgroundColor
        case icon
        case nextLevel
        case discount
    }

    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.createDate = try container.decodeIfPresent(Int.self, forKey: .createDate)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.targetCount = try container.decodeIfPresent(Int.self, forKey: .targetCount)
        self.amount = try container.decodeIfPresent(Double.self, forKey: .amount)
        self.isFixed = try container.decodeIfPresent(Bool.self, forKey: .isFixed)
        self.jobId = try container.decodeIfPresent(Int?.self, forKey: .jobId)
        self.backgroundColor = try container.decodeIfPresent(String.self, forKey: .backgroundColor)
        self.icon = try container.decodeIfPresent(String.self, forKey: .icon)
        if let icon {
            self.icon = NetworkManager.shared.baseUrl + "/image/loyalty/" + icon
        }
        self.nextLevel = try container.decodeIfPresent(Loyalty.self, forKey: .nextLevel)
        self.discount = try container.decodeIfPresent(Double.self, forKey: .discount)
    }
}

//indirect enum NextLevel: Decodable {
//    case loyalty(Loyalty)
//    
//    enum CodingKeys: String, CodingKey {
//            case loyalty
//    }
//    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        if let loyalty = try? container.decode(Loyalty.self, forKey: .loyalty) {
//            self = .loyalty(loyalty)
//        } else {
//            throw DecodingError.dataCorrupted(
//                DecodingError.Context(
//                    codingPath: decoder.codingPath,
//                    debugDescription: "Failed to decode NextLevel"
//                )
//            )
//        }
//    }
//}
