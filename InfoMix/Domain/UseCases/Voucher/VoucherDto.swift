//
//  VoucherDto.swift
//  InfoMix
//
//  Created by Temur on 17/06/2025.
//  Copyright © 2025 InfoMix. All rights reserved.
//

import Foundation
import ValidatedPropertyKit
import Dto
import Localize_Swift

struct VoucherDto: Dto {
    @Validated(.amountMoreThan(30, message: "At least should be 30 balls".localized()))
    var amount: String?
    
    var validatedProperties: [ValidatedProperty] {
        return [_amount]
    }
    
    init(amount: String) {
        self.amount = amount
    }
    
    init() { }
    
    static func validateAmount(_ amount: String) -> Result<String, ValidationError> {
        VoucherDto()._amount.isValid(value: amount)
    }
}
