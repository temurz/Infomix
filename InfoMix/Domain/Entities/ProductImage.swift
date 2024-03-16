//
//  ProductImage.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 08/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Then

struct ProductImage: Identifiable {
    var id = 0
    var originalImage: String?
    var smallImage: String?
}


extension ProductImage: Then, Equatable {
    static func == (lhs: ProductImage, rhs: ProductImage) -> Bool {
        return lhs.id == rhs.id
    }
}

extension ProductImage: Decodable {
    enum CodingKeys: String, CodingKey {
        case id="id"
        case originalImage = "originalImageFilename"
        case smallImage = "smallImageFilename"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? 0
        originalImage = NetworkManager.shared.baseUrl + "/image/product/" + (try values.decodeIfPresent(String.self, forKey: .originalImage) ?? "")
        smallImage = NetworkManager.shared.baseUrl + "/image/product/" + (try values.decodeIfPresent(String.self, forKey: .smallImage) ?? "")
        
    }
}

