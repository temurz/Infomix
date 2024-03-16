//
//  ShowingCardsHistory.swift
//  InfoMix
//
//  Created by Temur on 25/01/22.
//  Copyright © 2022 InfoMix. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

protocol ShowingCardsHistory {
    var assembler: Assembler { get }
    var navigationController: UINavigationController { get }
}

extension ShowingCardsHistory{
    func showCardsHistory(){
        let view: MyCardsView = assembler.resolve(navigationController: navigationController)
        let vc = UIHostingController(rootView: view)
        vc.title = "My cards".localized()
        navigationController.pushViewController(vc, animated: true)
    }
}
