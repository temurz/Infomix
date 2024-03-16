//
//  EventDetailNavigator.swift
//  CleanArchitecture
//
//  Created by Temur on 18/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import UIKit


protocol EventDetailNavigatorType {

}

struct EventDetailNavigator: EventDetailNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
}
