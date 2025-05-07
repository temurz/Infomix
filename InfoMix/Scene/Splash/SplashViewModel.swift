//
//  SplashViewModel.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 09/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import Combine
import Foundation
import SwiftUI

struct SplashViewModel {
    let navigator: SplashNavigatorType
    let getCardConfigUseCase: GetCardConfigUseCaseType
    var cardConfig: CardConfig?
    let startedTime = DispatchTime.now()
    private let startTrigger = PassthroughSubject<Void, Never>()
}

// MARK: - ViewModelType
extension SplashViewModel: ViewModel {
    struct Input {
        let startTrigger: Driver<Void>
        let loadTrigger: Driver<CardConfigInput>
    }
    
    final class Output: ObservableObject {
        @Published var isLoading: Bool = false
        @Published var cardConfig: CardConfig = CardConfig(configCode: "")
        @Published var alert: AlertMessage = AlertMessage()
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        
        let output = Output()
        
        let getItemInput = GetItemInput(loadTrigger: input.loadTrigger, reloadTrigger: Driver.empty(), getItem: getCardConfigUseCase.getCardConfig)
        
        let(cardConfig, error, isLoading, _) = getItem(input: getItemInput).destructured
        
        cardConfig
            .sink(receiveValue: { it in
                var newConfig = it
                newConfig.normalizeSteps()
                output.cardConfig = newConfig
                CardConfig.shared = newConfig
                self.startTrigger.send()
            })
            .store(in: cancelBag)
        
        input.startTrigger
            .sink {
                self.startTrigger.send()
            }
            .store(in: cancelBag)
        
        error
            .receive(on: RunLoop.main)
            .map { AlertMessage(error: $0) }
            .assign(to: \.alert, on: output)
            .store(in: cancelBag)
        
        error
            .receive(on: RunLoop.main)
            .map { _ in
                self.startTrigger.send(())
            }
            .sink()
            .store(in: cancelBag)
        
        isLoading
            .assign(to: \.isLoading, on: output)
            .store(in: cancelBag)
        
        startTrigger
            .sink(receiveValue: { () in
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
                    if UserDefaults.standard.string(forKey: "token") != nil &&
                        UserDefaults.standard.string(forKey: "configCode") != nil{
                        
//                        NetworkManager.shared = NetworkManager(baseUrl: output.cardConfig.remoteUrl ?? "")
                        
                        self.navigator.showMain(cardConfig: output.cardConfig)
                    } else {
                        self.navigator.showLogin(cardConfig: output.cardConfig)
                    }
                    
                }
                
            })
            .store(in: cancelBag)
        
        return Output()
    }
}
