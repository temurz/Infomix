//
//  VoucherHistoryResponse.swift
//  InfoMix
//
//  Created by Temur on 13/06/2025.
//  Copyright © 2025 InfoMix. All rights reserved.
//


struct VoucherHistoryResponse: Decodable {
    let id: Int
    let transactionId: Int?
    let code: String?
    let amount: Double?
    let priceForICU: Int?
    let totalAmount: Double?
    let paidAmount: Double?
    let jobId: Int?
    let masterId: Int?
    let createDate: Int?
    let modifyDate: Int?
    let closedDate: Int?
    let paidDate: Int?
    let note: String?
    let status: String?
    let verifyCode: String?
    let departmentName: String?
    let departmentPhone: String?
    let confirmed: Bool?
}


