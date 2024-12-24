//
//  ProductEntry.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 08/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Then
import Foundation
struct ProductEntry {
    var id: Int = 0
    var createDate: Date?
    var productName: String?
    var productImage: String?
    var productId: Int?
    var orderId: Int?
    var promotionId: Int?
    var price: Double?
    var quantity: Int = 0
    var removed: Bool = false
    var outOfStock: Bool = false
    var priceChanged: Bool = false
}

extension ProductEntry: Then, Equatable {
    static func == (lhs: ProductEntry, rhs: ProductEntry) -> Bool {
        return lhs.id == rhs.id
    }
}

extension ProductEntry: Decodable {
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case createDate = "createDate"
        case productName = "productName"
        case productImage = "productImage"
        case productId = "productId"
        case orderId = "orderId"
        case promotionId = "promotionId"
        case price = "price"
        case quantity = "quantity"
        case removed = "removed"
        case outOfStock = "outOfStock"
        case priceChanged = "priceChanged"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? 0
        createDate = try values.decodeIfPresent(Double.self, forKey: .createDate)?.toWindowsDate()
        productName = try values.decodeIfPresent(String.self, forKey: .productName)
        productImage = NetworkManager.shared.baseUrl + "/image/product/" + (try values.decodeIfPresent(String.self, forKey: .productImage) ?? "")
        productId = try values.decodeIfPresent(Int.self, forKey: .productId)
        orderId = try values.decodeIfPresent(Int.self, forKey: .orderId)
        promotionId = try values.decodeIfPresent(Int.self, forKey: .promotionId)
        price = try values.decodeIfPresent(Double.self, forKey: .price)
        quantity = try values.decodeIfPresent(Int.self, forKey: .quantity) ?? 0
        removed = try values.decodeIfPresent(Bool.self, forKey: .removed) ?? false
        outOfStock = try values.decodeIfPresent(Bool.self, forKey: .outOfStock) ?? false
        priceChanged = try values.decodeIfPresent(Bool.self, forKey: .priceChanged) ?? false
    }
}

