//
//  StatusViewAssembler.swift
//  InfoMix
//
//  Created by Temur on 16/12/2024.
//  Copyright © 2024 InfoMix. All rights reserved.
//
import UIKit
protocol StatusViewAssembler {
    func resolve(navigationController: UINavigationController, loyalty: Loyalty?) -> StatusView
    func resolve(navigationController: UINavigationController, loyalty: Loyalty?) -> StatusViewModel
    func resolve(navigationController: UINavigationController) -> StatusViewNavigatorType
    func resolve() -> StatusViewUseCaseType
}

extension StatusViewAssembler {
    func resolve(navigationController: UINavigationController, loyalty: Loyalty?) -> StatusView {
        return StatusView(viewModel: resolve(navigationController: navigationController, loyalty: loyalty))
    }
    func resolve(navigationController: UINavigationController, loyalty: Loyalty?) -> StatusViewModel {
        return StatusViewModel(navigator: resolve(navigationController: navigationController), useCase: resolve(), loyalty: loyalty)
    }
}

extension StatusViewAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> StatusViewNavigatorType {
        return StatusViewNavigator(navigationController: navigationController)
    }

    func resolve() -> StatusViewUseCaseType {
        return StatusViewUseCase(gateway: resolve(), leaderBoardGateway: LeaderBoardGateway())
    }

}

extension StatusViewAssembler where Self: PreviewAssembler {
    func resolve(navigationController: UINavigationController) -> StatusViewNavigatorType {
        return StatusViewNavigator(navigationController: navigationController)
    }

    func resolve() -> StatusViewUseCaseType {
        return StatusViewUseCase(gateway: resolve(), leaderBoardGateway: LeaderBoardGateway())
    }

}
