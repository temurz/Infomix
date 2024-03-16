//
//  EventsNavigator.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 13/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import UIKit

protocol EventsNavigatorType {
    func toEventDetail(event: Event)

}

struct EventsNavigator: EventsNavigatorType, ShowingEventDetail {
    
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
    
}
