//
//  ViewRouter.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 11/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import Combine

protocol ViewRouter: ObservableObject{
    var selectedPageId: String {get}
    var pages: [TabBarItem] {get}
    func route(selectedPageId: String)
}
