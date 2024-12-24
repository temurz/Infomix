//
//  MyCardsNavigator.swift
//  InfoMix
//
//  Created by Temur on 24/01/22.
//  Copyright © 2022 InfoMix. All rights reserved.
//

import Foundation
import UIKit

protocol MyCardsNavigatorType {
    func toCardDetail(card: SerialCard)
    func popView()
}
struct MyCardsNavigator: MyCardsNavigatorType, ShowingCardsHistory, ShowingCardDetail, PopNavigator {
    func toCardDetail(card: SerialCard) {
        goToCardDetail(card: card)
    }
    
    
    
    
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
    
}
