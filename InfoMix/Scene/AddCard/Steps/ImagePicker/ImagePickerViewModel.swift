//
//  ImagePickerViewModel.swift
//  InfoMix
//
//  Created by Temur on 05/04/2024.
//  Copyright © 2024 InfoMix. All rights reserved.
//

import SwiftUI

class ImagePickerViewModel: ObservableObject {
    @Published var image: UIImage?
    @Published var showPicker = false
    @Published var source: PickerImage.Source = .library
    
    func showPhotoPicker() {
        if source == .camera {
            if !PickerImage.checkPermissions() {
                print("There is no camera on this device")
                return
            }
        }
        showPicker = true
    }
}
