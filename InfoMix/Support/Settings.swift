//
//  Settings.swift
//  InfoMix
//
//  Created by Temur on 18/06/2025.
//  Copyright © 2025 InfoMix. All rights reserved.
//

import Foundation

struct Settings {
    static var isTestFlight = Bundle.main.appStoreReceiptURL?.lastPathComponent == "sandboxReceipt"
    
    static var isTestFlightOrDebug: Bool {
        if isTestFlight {
            return true
        }
        #if DEBUG
            return true
        #else
            return false
        #endif
    }
}
