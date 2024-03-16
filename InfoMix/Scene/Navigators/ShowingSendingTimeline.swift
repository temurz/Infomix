//
//  ShowingSendingTimeline.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 25/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//


import UIKit
import SwiftUI

protocol ShowingSendingTimeline {
    var assembler: Assembler { get }
    var navigationController: UINavigationController { get }
}

extension ShowingSendingTimeline {
    func showSendingTimeline(cardConfig: CardConfig) {
        let view: SendingTimelineView = assembler.resolve(navigationController: navigationController, cardConfig: cardConfig)
        
        
        let vc = UIHostingController(rootView: view)
        navigationController.pushViewController(vc, animated: true)
    }
}


