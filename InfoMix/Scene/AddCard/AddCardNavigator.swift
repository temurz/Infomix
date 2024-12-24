//
//  AddCardNavigator.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 25/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//
import SwiftUI

protocol AddCardNavigatorType{
    func showSendingTimeline(cardConfig:CardConfig)
    func showScanner(onFound: @escaping (_ code: String)->Void)
    func popView()
}

struct AddCardNavigator: AddCardNavigatorType , ShowingSendingTimeline, ShowingScanner, PopNavigator {
   
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
}

