//
//  ShowingEventList.swift
//  CleanArchitecture
//
//  Created by Temur on 18/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import UIKit
import SwiftUI

protocol ShowingEventList {
    var assembler: Assembler { get }
    var navigationController: UINavigationController { get }
}

extension ShowingEventList {
    func showEvents() {
        let view: EventsView = assembler.resolve(navigationController: navigationController)
        let vc = UIHostingController(rootView: view)
        vc.title = "Event List".localized()
        navigationController.pushViewController(vc, animated: true)
    }
}
