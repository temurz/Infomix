//
//  HomeNavigation.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 12/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//
import SwiftUI

protocol HomeNavigatorType{
    func showTransactionHistory()
    func showExchange()
    func showEvents()
    func showLocalUsers(cardConfig: CardConfig)
    func toEventDetail(event: Event)
    func showCardsHistory()
}

struct HomeNavigator: HomeNavigatorType, ShowingTransactionHistory , ShowingExchange, ShowingEventList, ShowingEventDetail, ShowingLocalUsers, ShowingCardsHistory {
    func showLocalUsers(cardConfig: CardConfig) {
        self.showLocalUsers(cardConfig: cardConfig, forceActiveUser: false)
    }
    

    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
}
