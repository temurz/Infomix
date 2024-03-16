//
//  ShowingEventDetail.swift
//  CleanArchitecture
//
//  Created by Temur on 18/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import UIKit
import SwiftUI

protocol ShowingEventDetail {
    var assembler: Assembler { get }
    var navigationController: UINavigationController { get }
}

extension ShowingEventDetail {
    func toEventDetail(event: Event) {
        let view: EventDetailView = assembler.resolve(navigationController: navigationController, event: event)
        let vc = UIHostingController(rootView: view)
        vc.title = "Event Detail"
        navigationController.pushViewController(vc, animated: true)
    }
}
