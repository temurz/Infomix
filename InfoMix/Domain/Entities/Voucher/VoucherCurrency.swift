//
//  VoucherCurrency.swift
//  InfoMix
//
//  Created by Temur on 13/06/2025.
//  Copyright © 2025 InfoMix. All rights reserved.
//


struct VoucherCurrency: Decodable {
    let id: Int
    var createDate: Int?
    var entityStatus: String?
    var amount: Int?
    var effectiveDate: Int?
    var jobId: Int?
}
