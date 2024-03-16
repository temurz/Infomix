//
//  ShoppingCard.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 05/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Foundation

struct Order : Identifiable {
    var id = 0
    var entryCount: Int = 0
    var totalAmount: Double = 0.0
    var entries = [ProductEntry]()
    var createdDate: Date?
    var closedDate: Date?
    var status: String = ""
    var statusText: String = ""
}

extension Order : Decodable {
    enum CodingKeys: String, CodingKey {
        case id="id"
        case entryCount = "totalProducts"
        case totalAmount = "totalScore"
        case entries = "productEntries"
        case createdDate = "createDate"
        case closedDate = "closedDate"
        case status = "status"
        case statusText = "statusText"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? 0
        status = try values.decodeIfPresent(String.self, forKey: .status) ?? ""
        statusText = try values.decodeIfPresent(String.self, forKey: .statusText) ?? ""
        entries  = try values.decodeIfPresent([ProductEntry].self, forKey: .entries) ?? [ProductEntry]()
        
        entryCount = try values.decodeIfPresent(Int.self, forKey: .entryCount) ?? 0
        totalAmount = try values.decodeIfPresent(Double.self, forKey: .totalAmount) ?? 0.0
        if entries.count > 0 && entryCount==0{
            entryCount = entries.reduce(0) { $0 + $1.quantity}
        }
        if entries.count > 0 && totalAmount == 0.0 {
            totalAmount = entries.reduce(0) { $0 + ($1.salesPrice * Double($1.quantity))}
        }
        
    
    }
    
    func contains(product: Product) -> Bool{
        self.entries.contains { entry in
            entry.product.id == product.id
        }
    }
    
    func isEditable()->Bool {
        self.status == "Draft" && self.entries.count > 0
    }
}
