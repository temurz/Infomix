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
    var entries = [ProductEntry]()
    var createdDate: Date?
    var closedDate: Date?
    var status: String?
    var totalPrice: Double = 0
    var totalProducts: Int = 0
    var notice: String?
    var cancelable: Bool = false
    var discount: Double?

//    var current: Boolean = false
//    var id: Int = 0
//    var createDate: Date? = null
//    var modifyDate: Date? = null
//    var status: String? = null
//    var items: List<OrderItem>? = null
//    var closedDate: Date? = null
//    var totalPrice: Double? = null
//    var totalProducts: Int = 0
//    var notice: String? = null
//    var cancelable: Boolean = false
//    var discount: Double? = null
//
//    fun totalAmount():Double? = totalPrice?.times(1.00 - (discount ?: 0.0) / 100.00)
}

extension Order : Decodable {
    enum CodingKeys: String, CodingKey {
        case id="id"
        case entries = "items"
        case createdDate = "createDate"
        case closedDate = "closedDate"
        case status = "status"
        case totalPrice = "totalPrice"
        case totalProducts = "totalProducts"
        case cancelable = "cancelable"
        case discount = "discountInPercentage"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? 0
        status = try values.decodeIfPresent(String.self, forKey: .status)
        entries  = try values.decodeIfPresent([ProductEntry].self, forKey: .entries) ?? [ProductEntry]()
        createdDate = try values.decodeIfPresent(Double.self, forKey: .createdDate)?.toWindowsDate()
        closedDate = try values.decodeIfPresent(Double.self, forKey: .closedDate)?.toWindowsDate()
        totalPrice = try values.decodeIfPresent(Double.self, forKey: .totalPrice) ?? 0
        totalProducts = try values.decodeIfPresent(Int.self, forKey: .totalProducts) ?? 0
        cancelable = try values.decodeIfPresent(Bool.self, forKey: .cancelable) ?? false
        discount = try values.decodeIfPresent(Double.self, forKey: .discount)


    
    }
    
    func contains(product: Product) -> Bool{
        self.entries.contains { entry in
            entry.productId == product.id
        }
    }
    
    func isEditable()->Bool {
        self.id == ShoppingCart.shared.orderId && self.totalProducts > 0
    }

    var subTotalAmount: Double {
        totalPrice
    }

    var totalAmount: Double {
        totalPrice * (1.0 - (discount ?? 0.0) / 100.0)
    }

    mutating func addOrUpdate(entry: ProductEntry) {
        let newEntry = self.entries.first { $0.id == entry.id }
        if var newEntry {
            newEntry.quantity = entry.quantity
            self.entries.removeAll { $0.id == entry.id }
            self.entries.append(newEntry)
        } else {
            self.entries.append(entry)
        }
        self.totalProducts = self.entries.reduce(0) { $0 + $1.quantity }
        self.totalPrice = self.entries.reduce(0) { $0 + (Double($1.quantity) * ($1.price ?? 0)) }
    }

    mutating func delete(entry: ProductEntry) {
        self.entries.removeAll { $0.id == entry.id }
        self.totalProducts = self.entries.reduce(0) { $0 + $1.quantity }
        self.totalPrice = self.entries.reduce(0) { $0 + (Double($1.quantity) * ($1.price ?? 0)) }
    }
}
