//
//  Loyalty.swift
//  InfoMix
//
//  Created by Temur on 09/12/2024.
//  Copyright © 2024 InfoMix. All rights reserved.
//

import Foundation
import Localize_Swift
class Loyalty: Decodable {
    let id: Int?
    let createDate : Int?
    let name : String?
    let description : String?
    let targetCount : Int?
    let serialCardCount : Int?
    let amount : Double?
    let isFixed : Bool?
    let jobId : Int?
    let backgroundColor : String?
    var icon : String?
    let nextLevel: Loyalty?
    let discount: Double?

    init(id: Int?, createDate: Int?, name: String?, description: String?, targetCount: Int?, amount: Double?, isFixed: Bool?, jobId: Int?, backgroundColor: String?, icon: String?, nextLevel: Loyalty?, discount: Double?, serialCardCount: Int?) {
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
        self.serialCardCount = serialCardCount
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
        case serialCardCount
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
        self.jobId = try container.decodeIfPresent(Int.self, forKey: .jobId)
        self.backgroundColor = try container.decodeIfPresent(String.self, forKey: .backgroundColor)
        self.icon = try container.decodeIfPresent(String.self, forKey: .icon)
        if let icon {
            self.icon = NetworkManager.shared.baseUrl + "/image/loyalty/" + icon
        }
        self.nextLevel = try container.decodeIfPresent(Loyalty.self, forKey: .nextLevel)
        self.discount = try container.decodeIfPresent(Double.self, forKey: .discount)
        self.serialCardCount = try container.decodeIfPresent(Int.self, forKey: .serialCardCount)
    }


//    var description: String? = null
//
//
//    if ((result.amount ?: 0.0) > 0.0) {
//
//
//        description = if (result.isFixed) getString(
//            R.string.loyalty_bonus_fixed_description, (result.amount?.toInt() ?: 0)
//        ) else getString(
//            R.string.loyalty_bonus_persentage_description, (result.amount?.toInt() ?: 0)
//        )
//    }
//    if ((result.discount ?: 0.0) > 0.0) {
//
//        if (description?.isNotEmpty() == true) description += "\n"
//
//        description += getString(
//            R.string.loyalty_bonus_discount_for_products, (result.discount?.toInt() ?: 0)
//        )
//    }

    func displayDescription() -> String {
        var description = ""
        if (id ?? 0) > 0 {
            if (amount ?? 0) > 0.0 {
                if isFixed ?? false {
                    description += String(format: "At this level, +%@ point is awarded for a successfully sent card.".localized(), "\(amount ?? 0)")
                } else {
                    description += String(format: "An additional score of %@%% of the submitted score is awarded for a successfully submitted card at this level.".localized(), "\(amount ?? 0)")
                }
            }
            if discount ?? 0 > 0.0 {
                if !description.isEmpty {
                    description += "\n"
                }
                description += String(format: "Special %@%% discount on all products.".localized(), "\(discount ?? 0)")
            }
        } else {
            description = "Send card and get loyalty level".localized()
        }

        return description
    }

    func displayName() -> String {
        if (id ?? 0) > 0 {
            return name ?? ""
        } else {
            return "No level".localized()
        }
    }
}
