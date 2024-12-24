//
//  Product.swift
//  CleanArchitecture
//
//  Created by Tuan Truong on 7/14/20.
//  Copyright © 2020 Tuan Truong. All rights reserved.
//

import Then
import Foundation

struct Promotion: Decodable {
    var id: Int = 0
    var name: String?
    var description: String?
    var createDate: Date?
    var endDate: Date?
    var startDate: Date?
    var untilToEnd: Int?
}

struct Product: Identifiable {
    var id = 0
    var images: [ProductImage]?
    var promotionId: Int?
    var categoryId: Int?
    var categoryName: String?
    var brandId: Int?
    var brandName: String?
    var price: Double = 0
    var priceInPromotion: Double?
    var promotion: Promotion?
    var inStock: Double = 0
    var name: String?
    var description: String?
    var createDate: Date?
    var image: String?

    func available() -> Bool {
        return inStock > 0.0 && ((price ?? 0.0) > 0.0 || (priceInPromotion ?? 0.0) > 0.0)
    }
}


extension Product: Then, Equatable {
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Product: Decodable {
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case images = "images"
        case promotionId = "promotionId"
        case categoryId = "categoryId"
        case categoryName = "categoryName"
        case brandId = "brandId"
        case brandName = "brandName"
        case price = "price"
        case priceInPromotion = "priceInPromotion"
        case promotion = "promotion"
        case inStock = "stock"
        case name = "name"
        case description = "description"
        case createDate = "createDate"
        case image = "image"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? 0
        images = try values.decodeIfPresent([ProductImage].self, forKey: .images)
        promotionId = try values.decodeIfPresent(Int.self, forKey: .promotionId)
        categoryId = try values.decodeIfPresent(Int.self, forKey: .categoryId)
        categoryName = try values.decodeIfPresent(String.self, forKey: .categoryName)
        brandId = try values.decodeIfPresent(Int.self, forKey: .brandId)
        brandName = try values.decodeIfPresent(String.self, forKey: .brandName)
        price = try values.decodeIfPresent(Double.self, forKey: .price) ?? 0
        priceInPromotion = try values.decodeIfPresent(Double.self, forKey: .priceInPromotion)
        promotion = try values.decodeIfPresent(Promotion.self, forKey: .promotion)
        inStock = try values.decodeIfPresent(Double.self, forKey: .inStock) ?? 0
        name = try values.decodeIfPresent(String.self, forKey: .name)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        createDate = try values.decodeIfPresent(Double.self, forKey: .createDate)?.toWindowsDate()
        image = NetworkManager.shared.baseUrl + "/image/product/" + (try values.decodeIfPresent(String.self, forKey: .image) ?? "")
    }
}

