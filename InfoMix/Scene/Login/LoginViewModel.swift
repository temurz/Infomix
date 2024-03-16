//
//  LoginViewModel.swift
//  CleanArchitecture
//
//  Created by Tuan Truong on 7/14/20.
//  Copyright © 2020 Tuan Truong. All rights reserved.
//

import Combine
import SwiftUI
import ValidatedPropertyKit
import CombineExt
import Localize_Swift

struct LoginViewModel {
    let cardConfig: CardConfig
    let navigator: LoginNavigatorType
    let useCase: LoginUseCaseType
}

// MARK: - ViewModelType
extension LoginViewModel: ViewModel {
    final class Input: ObservableObject {
        @Published var username = ""
        @Published var password = ""
        @Published var configCode = ""
        @Published var change = ""
        let loginTrigger: Driver<Void>
        let languageTrigger : Driver<String>
        let onlineApplicationTrigger : Driver<Void>
        let getConfigsTrigger : Driver<Void>
        
        init(loginTrigger: Driver<Void>, languageTrigger: Driver<String>, onlineApplicationTrigger: Driver<Void>,getConfigstrigger: Driver<Void>) {
            self.loginTrigger = loginTrigger
            self.languageTrigger = languageTrigger
            self.onlineApplicationTrigger = onlineApplicationTrigger
            self.getConfigsTrigger = getConfigstrigger
        }
    }
    
    final class Output: ObservableObject {
        @Published var isLoginEnabled = true
        @Published var isLoading = false
        @Published var alert = AlertMessage()
        @Published var usernameValidationMessage = ""
        @Published var passwordValidationMessage = ""
        @Published var configCodeValidationMessage = ""
        @Published var configs = [CardConfig]()
        @Published var service = "Choose a service".localized()
        @Published var chosenConfig = CardConfig()
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let errorTracker = ErrorTracker()
        let activityTracker = ActivityTracker(false)
        let output = Output()
        
        let usernameValidation = Publishers
            .CombineLatest(input.$username, input.loginTrigger)
            .map { $0.0 }
            .map(LoginDto.validateUserName(_:))
        
        usernameValidation
            .asDriver()
            .map { $0.message }
            .assign(to: \.usernameValidationMessage, on: output)
            .store(in: cancelBag)
        
        let passwordValidation = Publishers
            .CombineLatest(input.$password, input.loginTrigger)
            .map { $0.0 }
            .map(LoginDto.validatePassword(_:))
            
        passwordValidation
            .asDriver()
            .map { $0.message }
            .assign(to: \.passwordValidationMessage, on: output)
            .store(in: cancelBag)
        
        Publishers
            .CombineLatest(usernameValidation, passwordValidation)
            .map { $0.0.isValid && $0.1.isValid }
            .assign(to: \.isLoginEnabled, on: output)
            .store(in: cancelBag)
        
        let configCodeValidation = Publishers
            .CombineLatest(input.$configCode, input.loginTrigger)
            .map {$0.0}
            .map(LoginDto.validateConfigCode(_:))
        
        configCodeValidation
            .asDriver()
            .map {$0.message}
            .assign(to: \.configCodeValidationMessage, on: output)
            .store(in: cancelBag)
        
        
        let getCongfigsListInput = GetListInput(loadTrigger: input.getConfigsTrigger, reloadTrigger: Driver.empty(), getItems: useCase.getCardConfigs)
        
        let (configs, error, _, _) = getList(input: getCongfigsListInput).destructured
        
        configs
            .handleEvents(receiveOutput:{
              it in
                output.configs = it
            })
            .sink()
            .store(in: cancelBag)
        
        error
            .receive(on: RunLoop.main)
            .map {
                AlertMessage(error: $0)
            }
            .assign(to: \.alert, on: output)
            .store(in: cancelBag)
        
        input.languageTrigger.handleEvents(receiveOutput: { it in
            Localize.setCurrentLanguage(it)
        }).sink().store(in: cancelBag)
        
        input.loginTrigger
            .delay(for: 0.1, scheduler: RunLoop.main)  // waiting for username/password validation
            .filter { _ in output.isLoginEnabled && output.chosenConfig.configCode != "" }
            .map { _ in
                self.useCase.login(dto: LoginDto(username: input.username, password: input.password, configCode: output.chosenConfig.configCode))
                    .trackError(errorTracker)
                    .trackActivity(activityTracker)
                    .asDriver()
            }
            .switchToLatest()
            .sink(receiveValue: { certificate in
                if output.configs.count == 1{
                    CardConfig.shared = output.configs[0]
                    output.chosenConfig = output.configs[0]
                    input.configCode = output.configs[0].configCode
                    UserDefaults.standard.set(input.configCode, forKey: "configCode")
                    UserDefaults.standard.set(output.chosenConfig.configVersion, forKey: "configVersion")
                }
                self.navigator.showMainOrBack(cardConfig: output.chosenConfig)
            })
            .store(in: cancelBag)
        
        input.onlineApplicationTrigger.sink{
            navigator.showOnlineApplication()
        }.store(in: cancelBag)
        
        errorTracker
            .receive(on: RunLoop.main)
            .map {
                print($0)
                return AlertMessage(error: $0)
            }
            .assign(to: \.alert, on: output)
            .store(in: cancelBag)
            
        activityTracker
            .receive(on: RunLoop.main)
            .assign(to: \.isLoading, on: output)
            .store(in: cancelBag)
        
        return output
    }
}
