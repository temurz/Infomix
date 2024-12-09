//
//  HomeAssembler.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 12/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import UIKit

protocol HomeAssembler {
    func resolve(navigationController: UINavigationController, cardConfig: CardConfig) -> HomeViewModel
    func resolve(navigationController: UINavigationController, cardConfig: CardConfig) -> HomeView
    func resolve(navigationController: UINavigationController) -> HomeNavigatorType
    func resolve()-> HomeAttachedViewType
    func resolve() -> CurrentUserUseCaseType
    func resolve() -> LastEventsUseCaseType
    func resolve() -> FcmTokenUseCaseType
    func resolve() -> GetLoyaltyViewUseCaseType
    func resolve() -> GetStatisticsViewUseCaseType
}

extension HomeAssembler {
    
    
    func resolve(navigationController: UINavigationController, cardConfig: CardConfig) -> HomeView {
        let vm: HomeViewModel = resolve(navigationController: navigationController,cardConfig: cardConfig)
        let vc = HomeView(viewModel: vm, homeAttechedViews: resolve())
        return vc
    }
    
    func resolve(navigationController: UINavigationController, cardConfig: CardConfig) -> HomeViewModel {
        return HomeViewModel(
            homeNavigator: resolve(navigationController: navigationController),
            currentUserUseCase: resolve(),
            lastEventsUseCase: resolve(),
            fcmTokenUseCase: resolve(),
            getStatisticsUseCase: resolve(),
            getLoyaltyUseCase: resolve(),
            cardConfig: cardConfig
        )
    }
    
}
extension HomeAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> HomeNavigatorType {
        return HomeNavigator(assembler: self, navigationController: navigationController)
    }
  
    
    func resolve() -> CurrentUserUseCaseType{
        return CurrentUserUseCase(authGateway: resolve())
    }
    
    func resolve() -> HomeAttachedViewType{
        return HomeAttachedView(assembler: self)
    }
    
    func resolve() -> LastEventsUseCaseType{
        return LastEventsUseCase(eventGateway: resolve())
    }
    func resolve() -> FcmTokenUseCaseType{
        return FcmTokenUseCase(authGateway: resolve())
    }
    
    func resolve() -> GetLoyaltyViewUseCaseType {
        return GetLoyaltyViewUseCase(gateway: resolve())
    }
    
    func resolve() -> GetStatisticsViewUseCaseType {
        return GetStatisticsViewUseCase(gateway: resolve())
    }
}

extension HomeAssembler where Self: PreviewAssembler {
    func resolve(navigationController: UINavigationController) -> HomeNavigatorType {
        return HomeNavigator(assembler: self, navigationController: navigationController)
    }
    
    
    func resolve() -> CurrentUserUseCaseType{
        return CurrentUserUseCase(authGateway: resolve())
    }
    
    func resolve() -> LastEventsUseCaseType{
        return LastEventsUseCase(eventGateway: resolve())
    }
    
    func resolve() -> HomeAttachedViewType{
        return HomeAttachedView(assembler: self)
    }
    
    func resolve() -> FcmTokenUseCaseType{
        return FcmTokenUseCase(authGateway: resolve())
    }
  
    func resolve() -> GetLoyaltyViewUseCaseType {
        return GetLoyaltyViewUseCase(gateway: resolve())
    }
    
    func resolve() -> GetStatisticsViewUseCaseType {
        return GetStatisticsViewUseCase(gateway: resolve())
    }
}
