//
//  ProductEntry.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 08/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Then

struct ProductEntry {
    var id = 0
    var salesPrice = 0.0
    var quantity = 0
    var product: Product
    
    
}

extension ProductEntry: Then, Equatable {
    static func == (lhs: ProductEntry, rhs: ProductEntry) -> Bool {
        return lhs.id == rhs.id
    }
}

extension ProductEntry: Decodable {
    enum CodingKeys: String, CodingKey {
        case id="id"
        case salesPrice = "salesBall"
        case quantity = "quantity"
        case product = "product"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? 0
        salesPrice = try values.decodeIfPresent(Double.self, forKey: .salesPrice) ?? 0.0
        quantity = try values.decodeIfPresent(Int.self, forKey: .quantity) ?? 0
        product = try values.decodeIfPresent(Product.self, forKey: .product) ?? Product()
    }
}

