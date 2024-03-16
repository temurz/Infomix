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
}

struct SendingTimelineNavigator: SendingTimelineNavigatorType , ShowingRoot {

    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
}


