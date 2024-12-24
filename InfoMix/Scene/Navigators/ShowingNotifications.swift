//
//  File.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 12/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import UIKit
import SwiftUI

protocol ShowingNotifications {
    var assembler: Assembler { get }
    var navigationController: UINavigationController { get }
}

extension ShowingNotifications {
    func showNotifications() {
        let view: NotificationsView = assembler.resolve(navigationController: navigationController)
        let vc = UIHostingController(rootView: view)
//        vc.title = "Notifications"
        navigationController.pushViewController(vc, animated: true)
    }
    
}
