//
//  SendingTimelineAssembler.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 24/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//


import UIKit

protocol SendingTimelineAssembler {
    func resolve(navigationController: UINavigationController,cardConfig: CardConfig) -> SendingTimelineView
    func resolve(navigationController: UINavigationController,cardConfig: CardConfig) -> SendingTimelineViewModel
    func resolve()->SendingConnectUseCaseType
    func resolve()->SendingSerialNumbersUseCaseType
    func resolve()->SendingAdditionalDataUseCaseType
    func resolve()->CalculateBonusesUseCaseType
    func resolve()->OpenDisputeUseCaseType
    func resolve(navigationController: UINavigationController)->SendingTimelineNavigatorType
}

extension SendingTimelineAssembler {
    func resolve(navigationController: UINavigationController, cardConfig: CardConfig) -> SendingTimelineView {
        return SendingTimelineView(viewModel: resolve(navigationController: navigationController, cardConfig: cardConfig))
    }
    func resolve(navigationController: UINavigationController, cardConfig: CardConfig) -> SendingTimelineViewModel {
        return SendingTimelineViewModel(cardConfig: cardConfig, connectUseCase: resolve(), sendSerialNumbersUseCase: resolve(), sendAdditionalDataUseCase: resolve(), calculateBonusesUseCase: resolve(), openDisputeUseCase: resolve(), navigator: resolve(navigationController: navigationController))
    }
}

extension SendingTimelineAssembler where Self: DefaultAssembler {
    func resolve()->SendingConnectUseCaseType {
        SendingConnectUseCase(cardGateway: resolve())
    }
    func resolve()->SendingSerialNumbersUseCaseType {
        SendingSerialNumbersUseCase(cardGateway: resolve())
    }
    func resolve()->SendingAdditionalDataUseCaseType {
        SendingAdditionalDataUseCase(cardGateway: resolve())
    }
    func resolve()->CalculateBonusesUseCaseType {
        CalculateBonusesUseCase(cardGateway: resolve())
    }
    func resolve()->OpenDisputeUseCaseType {
        OpenDisputeUseCase(disputeGateway: resolve())
    }
    
    func resolve(navigationController: UINavigationController) -> SendingTimelineNavigatorType{
        SendingTimelineNavigator(assembler: self, navigationController: navigationController)
    }
}

extension SendingTimelineAssembler where Self: PreviewAssembler {
    func resolve()->SendingConnectUseCaseType {
        SendingConnectUseCase(cardGateway: resolve())
    }
    func resolve()->SendingSerialNumbersUseCaseType {
        SendingSerialNumbersUseCase(cardGateway: resolve())
    }
    func resolve()->SendingAdditionalDataUseCaseType {
        SendingAdditionalDataUseCase(cardGateway: resolve())
    }
    func resolve()->CalculateBonusesUseCaseType {
        CalculateBonusesUseCase(cardGateway: resolve())
    }
    func resolve()->OpenDisputeUseCaseType {
        OpenDisputeUseCase(disputeGateway: resolve())
    }
    
    func resolve(navigationController: UINavigationController) -> SendingTimelineNavigatorType{
        SendingTimelineNavigator(assembler: self, navigationController: navigationController)
    }
}

