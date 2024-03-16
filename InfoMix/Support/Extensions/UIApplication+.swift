//
//  UIApplication.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 09/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import UIKit

extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
    
    
}
