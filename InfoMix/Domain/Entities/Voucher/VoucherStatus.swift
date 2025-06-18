//
//  VoucherStatus.swift
//  InfoMix
//
//  Created by Temur on 13/06/2025.
//  Copyright © 2025 InfoMix. All rights reserved.
//


struct VoucherStatus: Decodable, Identifiable {
    let valueField: String?
    let textField: String?
    let selected: Bool?
    
    var id: String {
        return valueField ?? ""
    }
}

