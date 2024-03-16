//
//  PhoneFormatter.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 15/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import Foundation

class PhoneFormatter: Formatter {
    override func string(for obj: Any?) -> String? {
        if let string = obj as? String {
            return formattedPhone(phone: string)
        }
        return nil
    }
    
    override func getObjectValue(_ obj: AutoreleasingUnsafeMutablePointer<AnyObject?>?, for string: String, errorDescription error: AutoreleasingUnsafeMutablePointer<NSString?>?) -> Bool {
        obj?.pointee = string as AnyObject?
        return true
    }
    
    func formattedPhone(phone: String?) -> String? {
        let cleanPhoneNumber = phone?.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
                      
        guard let number = cleanPhoneNumber else { return "" }
        let mask = "+XXX XX XXX XX XX"
        var result = ""
        var index = number.startIndex
        for ch in mask where index < number.endIndex {
            if ch == "X" {
                result.append(number[index])
                index = number.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
}
