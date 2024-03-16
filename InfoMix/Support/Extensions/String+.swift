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
}
