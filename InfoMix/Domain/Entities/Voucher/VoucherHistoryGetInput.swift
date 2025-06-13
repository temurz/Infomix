//
//  VoucherHistoryGetInput.swift
//  InfoMix
//
//  Created by Temur on 13/06/2025.
//  Copyright © 2025 InfoMix. All rights reserved.
//


struct GetVoucherHistoryInput: Encodable {
    let from: String
    let to: String
    let status: String
}
