//
//  VoucherCurrency.swift
//  InfoMix
//
//  Created by Temur on 13/06/2025.
//  Copyright © 2025 InfoMix. All rights reserved.
//


struct VoucherCurrency: Decodable {
    let id: Int
    let createDate: Int?
    let entityStatus: String?
    let amount: Int?
    let effectiveDate: Int?
    let jobId: Int?
}
