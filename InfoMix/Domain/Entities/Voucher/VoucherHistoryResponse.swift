//
//  VoucherHistoryResponse.swift
//  InfoMix
//
//  Created by Temur on 13/06/2025.
//  Copyright © 2025 InfoMix. All rights reserved.
//


struct VoucherHistoryResponse: Decodable {
    let id: Int
    var transactionId: Int?
    var code: String?
    var amount: Double?
    var priceForICU: Int?
    var totalAmount: Double?
    var paidAmount: Double?
    var jobId: Int?
    var masterId: Int?
    var createDate: Int?
    var modifyDate: Int?
    var closedDate: Int?
    var paidDate: Int?
    var note: String?
    var status: String?
    var verifyCode: String?
    var departmentName: String?
    var departmentPhone: String?
    var confirmed: Bool?
}


