//
//  EventDetailAssembler.swift
//  CleanArchitecture
//
//  Created by Temur on 18/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import UIKit

protocol EventDetailAssembler {
    func resolve(navigationController: UINavigationController, event: Event) -> EventDetailView
    func resolve(navigationController: UINavigationController, event: Event) -> EventDetailViewModel
    func resolve(navigationController: UINavigationController) -> EventDetailNavigatorType
    func resolve() -> EventDetailUseCaseType
}

extension EventDetailAssembler {
    func resolve(navigationController: UINavigationController, event: Event) -> EventDetailView {
        EventDetailView(viewModel: resolve(navigationController: navigationController, event: event))
    }

    func resolve(navigationController: UINavigationController, event: Event) -> EventDetailViewModel {
        EventDetailViewModel(
            navigator: resolve(navigationController: navigationController),
            useCase: resolve(),
            event: event)
    }
}

extension EventDetailAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> EventDetailNavigatorType {
        EventDetailNavigator(assembler: self, navigationController: navigationController)
    }

    func resolve() -> EventDetailUseCaseType {
        EventDetailUseCase(eventGateway: resolve())
    }
}

extension EventDetailAssembler where Self: PreviewAssembler {
    func resolve(navigationController: UINavigationController) -> EventDetailNavigatorType {
        EventDetailNavigator(assembler: self, navigationController: navigationController)
    }

    func resolve() -> EventDetailUseCaseType {
        EventDetailUseCase(eventGateway: resolve())
    }
}


