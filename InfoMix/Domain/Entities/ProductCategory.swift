//
//  ProductCategory.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 07/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//
import Then

struct ProductCategory: Identifiable {
    var id = 0
    var name = ""
    var childrenCount = 0
    var parentId = 0
    var intent = ProductCategoryIntent()
}

extension ProductCategory: Then, Equatable {
    static func == (lhs: ProductCategory, rhs: ProductCategory) -> Bool {
        return lhs.id == rhs.id
    }
}

extension ProductCategory: Decodable {
    enum CodingKeys: String, CodingKey {
        case id="id"
        case name = "name"
        case childrenCount = "childrenCount"
        case parentId = "parentId"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? 0
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
        childrenCount = try values.decodeIfPresent(Int.self, forKey: .childrenCount) ?? 0
        parentId = try values.decodeIfPresent(Int.self, forKey: .parentId) ?? 0
    }
    
    func isExist() -> Bool {
        return id > 0
    }
}

