//
//  String.swift
//  InfoMix
//
//  Created by Temur on 04/04/22.
//  Copyright © 2022 InfoMix. All rights reserved.
//

import Foundation


extension String {
    func base64Encoded() -> String? {
        return data(using: .utf8)?.base64EncodedString()
    }

    func base64Decoded() -> String? {
        guard let data = Data(base64Encoded: self) else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
    func formatNumber(mask: String = "+XXX(XX) XXX-XX-XX") -> String {
        let cleanNumber = components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        var result = ""
        var startIndex = cleanNumber.startIndex
        let endIndex = cleanNumber.endIndex
        
        for char in mask where startIndex < endIndex {
            if char == "X" {
                result.append(cleanNumber[startIndex])
                startIndex = cleanNumber.index(after: startIndex)
            } else {
                result.append(char)
            }
        }
        
        return result
    }
    
    func getOnlyPhoneNumber() -> String {
        let text = self.filter("+0123456789.".contains)
        return text
    }
}
