//
//  SendingTimelineNavigator.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 30/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import SwiftUI

protocol SendingTimelineNavigatorType{
    func toRoot()
    func popView()
}

struct SendingTimelineNavigator: SendingTimelineNavigatorType , ShowingRoot, PopNavigator {

    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
}


