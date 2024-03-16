//
//  Product.swift
//  CleanArchitecture
//
//  Created by Tuan Truong on 7/14/20.
//  Copyright © 2020 Tuan Truong. All rights reserved.
//

import Then
import Foundation

struct Product: Identifiable {
    var id = 0
    var name = ""
    var price = 0.0
    var brandName = ""
    var images: [ProductImage]?
    var inStock = 0.0
    var description: String = ""
    var content = ""
}


extension Product: Then, Equatable {
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Product: Decodable {
    enum CodingKeys: String, CodingKey {
        case id="id"
        case name = "name"
        case images = "images"
        case priceInStore = "priceInScore"
        case inStock = "inStock"
        case description = "description"
        case content = "content"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? 0
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
        images = try values.decodeIfPresent([ProductImage].self, forKey: .images)
        if let inStockS = try values.decodeIfPresent(Decimal.self, forKey: .inStock) {
            inStock = Double(truncating: inStockS as NSNumber)
        }
        if let priceS = try values.decodeIfPresent(Decimal.self, forKey: .priceInStore){
            price = Double(truncating: priceS as NSNumber)
        }
        
        description = try values.decodeIfPresent(String.self, forKey: .description) ?? ""
        content = try values.decodeIfPresent(String.self, forKey: .content) ?? ""
    }
}

