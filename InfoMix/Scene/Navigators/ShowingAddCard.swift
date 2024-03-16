//
//  ShowingAddCard.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 22/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//


import UIKit
import SwiftUI

protocol ShowingAddCard {
    var assembler: Assembler { get }
    var navigationController: UINavigationController { get }
    var cardConfig: CardConfig { get }
}

extension ShowingAddCard {
    func showAddCard() {
        let view: AddCardView = assembler.resolve(navigationController: navigationController, cardConfig: cardConfig)
        let vc = UIHostingController(rootView: view)
        navigationController.pushViewController(vc, animated: true)
    }
}

