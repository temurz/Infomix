//
//  NotificationsNavigator.swift
//  CleanArchitecture
//
//  Created by Temur on 22/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Foundation
import UIKit

protocol NotificationsNavigatorType {
    func toEventDetail(id: Int32)
    func toOrder(id: Int)
    func toTransactionList()
}

struct NotificationsNavigator : NotificationsNavigatorType, ShowingEventDetail,ShowingShoppingCart ,ShowingTransactionHistory{
    func toEventDetail(id: Int32) {
        toEventDetail(event: Event(id: id))
    }
    
    func toOrder(id: Int) {
        showShoppingCart(order: Order(id: id))
    }
    
    func toTransactionList() {
        showTransactionHistory()
    }
    
    
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
}
