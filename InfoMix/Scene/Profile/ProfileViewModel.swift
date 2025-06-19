//
//  ShoppingViewModel.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 06/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Combine
import SwiftUI

struct ProfileViewModel {
    let certificate: CertificateItemViewModel
    let navigator: ProfileNavigatorType
    let logoutUseCase: LogoutUseCaseType
}

extension ProfileViewModel : ViewModel {
    
    struct Input {
        let logoutTrigger: Driver<Void>
        let openChangePasswordTrigger: Driver<Void>
        let openLanguageSettingTrigger: Driver<Void>
        let openNotificationSettingTrigger: Driver<Void>
        let showAboutTrigger: Driver<Void>
        let exitTrigger: Driver<Void>
    }
    
    final class Output: ObservableObject {
        
        @Published var certificate: CertificateItemViewModel
        @Published var alert = AlertMessage()
        @Published var isLoggingOut = false
        @Published var isEnabledNotification = false
        
        
        
        init(certificate: CertificateItemViewModel){
            self.certificate = certificate
        }
        
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        
        let errorTracker = ErrorTracker()
        let activityTracker = ActivityTracker(false)
        
        
        
        let output = Output(certificate: self.certificate)
        
        output.isEnabledNotification = UserDefaults.standard.bool(forKey: "enabled-notification")
        
        output.$isEnabledNotification.sink { toggled in
            UserDefaults.standard.set(toggled, forKey: "enabled-notification")
        }.store(in: cancelBag)
        
        input.openChangePasswordTrigger.sink { () in
            self.navigator.openChangePassword()
        }.store(in: cancelBag)
        
        
        
        input.openLanguageSettingTrigger.sink { () in
            self.navigator.openLanguageSettings()
        }.store(in: cancelBag)
        
        
        input.showAboutTrigger.sink { () in
            self.navigator.openAbout()
        }.store(in: cancelBag)
        
        input.logoutTrigger
            .map { _ in
                self.logoutUseCase.logout()
                    .handleEvents(receiveCompletion: { completion in
                        if case .failure(_) = completion {
                            UserDefaults.standard.removeObject(forKey: "token")
                            self.navigator.showSplash()
                        }
                    })
                    .trackError(errorTracker)
                    .trackActivity(activityTracker)
                    .asDriver()
            }
            .switchToLatest()
            .sink(receiveValue: { localUserCount in
                if let cc = certificate.cardConfig {
                    self.navigator.showLogin(cardConfig: cc)
                }else {
                    self.navigator.showSplash()
                }
            })
            .store(in: cancelBag)
        
        errorTracker
            .receive(on: RunLoop.main)
            .map {
                return $0 }
            .map { AlertMessage(error: $0) }
            .assign(to: \.alert, on: output)
            .store(in: cancelBag)
        
        activityTracker
            .receive(on: RunLoop.main)
            .assign(to: \.isLoggingOut, on: output)
            .store(in: cancelBag)
        
        
        return output
    }
    
}
