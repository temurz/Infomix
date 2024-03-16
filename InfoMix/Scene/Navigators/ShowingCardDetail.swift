//
//  ShowingCardDetail.swift
//  InfoMix
//
//  Created by Temur on 25/01/22.
//  Copyright © 2022 InfoMix. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

protocol ShowingCardDetail {
    var assembler: Assembler { get }
    var navigationController: UINavigationController { get }
}

extension ShowingCardDetail{
    func goToCardDetail(card: SerialCard){
        let view: MyCardsDetailView = assembler.resolve(navigationController: navigationController, serialCard: card)
        let vc = UIHostingController(rootView: view)
        vc.title = "Card"
        navigationController.pushViewController(vc, animated: true)
    }
}
