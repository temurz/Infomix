//
//  ErrorHandler.swift
//  InfoMix
//
//  Created by Damir Asamatdinov on 25/01/22.
//  Copyright © 2022 InfoMix. All rights reserved.
//

import SwiftUI

class ErrorHandler {
    
    static let shared = ErrorHandler()
    
    func consoleLogError(_ error: NSError) {
        print("Unresolved error \(error), \(error.userInfo)")
    }
    
    func alertErrorMessage(_ error: NSError) {
        // implement alert
    }
    
}
