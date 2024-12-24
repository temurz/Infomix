//
//  EventDetailNavigator.swift
//  CleanArchitecture
//
//  Created by Temur on 18/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import UIKit


protocol EventDetailNavigatorType {
    func popView()
}

struct EventDetailNavigator: EventDetailNavigatorType, PopNavigator {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
}
