//
//  ChangePasswordViewModel.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 17/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//


import Combine
import SwiftUI

struct ChangePasswordViewModel {
    let changePasswordUseCase: ChangePasswordUseCaseType
    let navigator: ChangePasswordNavigatorType
    let changePasswordTrigger = PassthroughSubject<ChangePasswordDto,Never>()
}

extension ChangePasswordViewModel : ViewModel {
    
    final class Input: ObservableObject {
        
         @Published var password: String = ""
         @Published var newPassword: String = ""
        let changePasswordTrigger: Driver<Void>
        
        
        init(changePasswordTrigger: Driver<Void>) {
            self.changePasswordTrigger = changePasswordTrigger
        }
    }
    
    final class Output: ObservableObject {
       
        @Published var alert = AlertMessage()
        @Published var isChangingPassword = false
        @Published var passwordValidationMessage = ""
        @Published var newPasswordValidationMessage = ""
        @Published var isChangeEnabled = true
        
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
      
        let errorTracker = ErrorTracker()
        let activityTracker = ActivityTracker(false)
        
        
        let passwordValidation = Publishers
            .CombineLatest(input.$password, input.changePasswordTrigger)
            .map { $0.0 }
            .map(ChangePasswordDto.validatePassword(_:))
            
        passwordValidation
            .asDriver()
            .map { $0.message }
            .assign(to: \.passwordValidationMessage, on: output)
            .store(in: cancelBag)
        
        
        let newPasswordValidation = Publishers
            .CombineLatest(input.$newPassword, input.changePasswordTrigger)
            .map { $0.0 }
            .map(ChangePasswordDto.validateNewPassword(_:))
            
        newPasswordValidation
            .asDriver()
            .map { $0.message }
            .assign(to: \.newPasswordValidationMessage, on: output)
            .store(in: cancelBag)
        
        Publishers
            .CombineLatest(passwordValidation, newPasswordValidation)
            .map { $0.0.isValid && $0.1.isValid }
            .assign(to: \.isChangeEnabled, on: output)
            .store(in: cancelBag)
        
        
        input.changePasswordTrigger
            .delay(for: 0.1, scheduler: RunLoop.main)  // waiting for username/password validation
            .filter { _ in output.isChangeEnabled }
            .map { _ in
                self.changePasswordUseCase.changePassword(dto: ChangePasswordDto(password: input.password, newPassword: input.newPassword))
                    .trackError(errorTracker)
                    .trackActivity(activityTracker)
                    .asDriver()
            }
            .switchToLatest()
            .sink(receiveValue: { success in
                if success {
                    self.navigator.back()
                } else {
                    output.alert = AlertMessage(title: "Error", message: "Change password failed", isShowing: true)
                }
            })
            .store(in: cancelBag)
        
        errorTracker
            .receive(on: RunLoop.main)
            .map { AlertMessage(error: $0) }
            .assign(to: \.alert, on: output)
            .store(in: cancelBag)
            
        activityTracker
            .receive(on: RunLoop.main)
            .assign(to: \.isChangingPassword, on: output)
            .store(in: cancelBag)
        
        return output
    }
    
}
