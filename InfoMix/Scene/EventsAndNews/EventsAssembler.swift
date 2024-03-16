//
//  EventsAssembler.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 13/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import UIKit

protocol EventsAssembler {
    func resolve(navigationController: UINavigationController) -> EventsView
    //    func resolve(navigationController: UINavigationController) -> RepoCollectionViewController
    func resolve(navigationController: UINavigationController) -> EventsViewModel
    func resolve(navigationController: UINavigationController) -> EventsNavigatorType
    func resolve() -> EventTypeUseCaseType
    func resolve() -> EventsUseCaseType
}

extension EventsAssembler {
    func resolve(navigationController: UINavigationController) -> EventsView {
        return EventsView(viewModel: resolve(navigationController: navigationController))
    }

    
    func resolve(navigationController: UINavigationController) -> EventsViewModel {
        return EventsViewModel(
            navigator: resolve(navigationController: navigationController),
            useCase: resolve(), typesUseCase: resolve()
        )
    }
}

extension EventsAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> EventsNavigatorType {
        return EventsNavigator(assembler: self, navigationController: navigationController)
    }
    
    func resolve() -> EventsUseCaseType {
        return EventsUseCase(eventGateway: resolve())
    }
    
    func resolve() -> EventTypeUseCaseType {
        return EventTypeUseCase(eventGateway: resolve())
    }
}

extension EventsAssembler where Self: PreviewAssembler {
    func resolve(navigationController: UINavigationController) -> EventsNavigatorType {
        return EventsNavigator(assembler: self, navigationController: navigationController)
    }
    
    func resolve() -> EventsUseCaseType {
        return EventsUseCase(eventGateway: resolve())
    }
    
    func resolve() -> EventTypeUseCaseType {
        return EventTypeUseCase(eventGateway: resolve())
    }
}
