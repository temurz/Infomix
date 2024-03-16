//
//  NotificationsAssembler.swift
//  CleanArchitecture
//
//  Created by Temur on 22/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Foundation
import UIKit

protocol NotificationsAssembler {
    
    func resolve(navigationController: UINavigationController) -> NotificationsView
    func resolve(navigationController: UINavigationController) -> NotificationsViewModel
    func resolve(navigationController: UINavigationController) -> NotificationsNavigatorType
    func resolve() -> NotificationsUseCaseType
}

extension NotificationsAssembler {
    func resolve(navigationController: UINavigationController) -> NotificationsView{
        return NotificationsView(viewModel: resolve(navigationController: navigationController))
    }
    
    func resolve(navigationController: UINavigationController) -> NotificationsViewModel {
        return NotificationsViewModel(navigator: resolve(navigationController: navigationController), useCase: resolve())
    }
}

extension NotificationsAssembler where Self: DefaultAssembler{
    func resolve(navigationController: UINavigationController) -> NotificationsNavigatorType{
        return NotificationsNavigator(assembler: self, navigationController: navigationController)
    }
    
    func resolve() -> NotificationsUseCaseType {
        return NotificationsUseCase(notificationsGateway: NotificationsGateway())
    }
    
}

extension NotificationsAssembler where Self: PreviewAssembler {
    func resolve(navigationController: UINavigationController) -> NotificationsNavigatorType{
        return NotificationsNavigator(assembler: self, navigationController: navigationController)
    }
    
    func resolve() -> NotificationsUseCaseType {
        return NotificationsUseCase(notificationsGateway: NotificationsGateway())
    }
}
