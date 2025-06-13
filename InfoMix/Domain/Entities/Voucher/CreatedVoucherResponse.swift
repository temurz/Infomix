//
//  CreatedVoucherResponse.swift
//  InfoMix
//
//  Created by Temur on 13/06/2025.
//  Copyright © 2025 InfoMix. All rights reserved.
//


struct CreatedVoucherResponse: Decodable {
    let id: Int
    let createDate: Int?
    let entityStatus: String?
    let code: String?
    let certificate: String?
    let masterId: Int?
    let jobId: Int?
    let amount: Double?
    let priceForICU: Int?
    let status: String?
    let total: Double?
}

