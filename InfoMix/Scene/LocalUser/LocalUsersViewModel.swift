//
//  LocalUserViewModel.swift
//  InfoMix
//
//  Created by Damir Asamatdinov on 25/01/22.
//  Copyright © 2022 InfoMix. All rights reserved.
//

import Combine
import UIKit

struct LocalUsersViewModel {
    let navigator: LocalUsersNavigatorType
    let getLocalUsersUseCase: GetLocalUsersUseCaseType
    let cardConfig: CardConfig
}

// MARK: - ViewModelType
extension LocalUsersViewModel: ViewModel {
    struct Input {
        let loadUsersTrigger: Driver<Void>
        let reloadUsersTrigger: Driver<Void>
        let activeTrigger: Driver<LocalUser>
        let addAccountTrigger: Driver<Void>
        let popViewTrigger: Driver<Void>
    }
    
    final class Output: ObservableObject {
        @Published var certificates = [LocalUser]()
        @Published var isLoading = false
        @Published var isReloading = false
        @Published var alert = AlertMessage()
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        
        let getListInput = GetListInput(loadTrigger: input.loadUsersTrigger, reloadTrigger: input.reloadUsersTrigger, getItems: getLocalUsersUseCase.getLocalUsers)
        
        let (users, error, isLoading, isReloading) = getList(input: getListInput).destructured
        
        users
            .assign(to: \.certificates, on: output)
            .store(in: cancelBag)
        
        error
            .receive(on: RunLoop.main)
            .map { AlertMessage(error: $0) }
            .assign(to: \.alert, on: output)
            .store(in: cancelBag)
        
        isLoading
            .assign(to: \.isLoading, on: output)
            .store(in: cancelBag)
        
        isReloading
            .assign(to: \.isReloading, on: output)
            .store(in: cancelBag)
        
        input.activeTrigger.sink { localUser in
            UserDefaults.standard.set(localUser.token, forKey: "token")
            self.navigator.showMain(cardConfig: self.cardConfig)
        }.store(in: cancelBag)
        
        
        input.addAccountTrigger.sink { localUser in
            self.navigator.showLogin(cardConfig: self.cardConfig)
        }.store(in: cancelBag)

        input.popViewTrigger
            .sink {
                navigator.popView()
            }
            .store(in: cancelBag)

        return output
    }
}
