//
//  PickerImage.swift
//  InfoMix
//
//  Created by Temur on 05/04/2024.
//  Copyright © 2024 InfoMix. All rights reserved.
//

import UIKit

enum PickerImage {
    enum Source: String {
        case library, camera
    }
    
    static func checkPermissions() -> Bool {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            return true
        } else {
            return false
        }
    }
}
