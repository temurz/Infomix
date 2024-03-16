//
//  Double+.swift
//  CleanArchitecture
//
//  Created by Tuan Truong on 7/15/20.
//  Copyright © 2020 Tuan Truong. All rights reserved.
//

import Foundation

extension Double {
    var currency: String {
        return String(format: "$%.02f", self)
    }
    
    func groupped(fractionDigits: Int?, groupSeparator: String?) -> String{
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.currencySymbol =  ""
        numberFormatter.maximumFractionDigits = 0
        
        if groupSeparator != nil{
                 numberFormatter.groupingSeparator = groupSeparator!
                 numberFormatter.groupingSize = 3
                 numberFormatter.usesGroupingSeparator = true
            }
        if fractionDigits != nil && fractionDigits ?? 0 > 0 {
             numberFormatter.decimalSeparator = "."
             numberFormatter.maximumFractionDigits = fractionDigits!
        }
             return numberFormatter.string(from: self as NSNumber)!
    }
    
    func toWindowsDate()->Date {
        Date.init(timeIntervalSince1970: Double(self)/1000)
    }
}
