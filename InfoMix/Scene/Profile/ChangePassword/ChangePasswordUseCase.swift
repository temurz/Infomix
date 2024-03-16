//
//  ChangePasswordUseCase.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 17/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Combine
import Dto
import ValidatedPropertyKit

protocol ChangePasswordUseCaseType {
    func changePassword(dto: ChangePasswordDto) -> Observable<Bool>
}

struct ChangePasswordUseCase: ChangePasswordUseCaseType, ChangingPassword {
    let authGateway: AuthGatewayType
    
}

struct ChangePasswordDto: Dto {
    
    @Validated(.nonEmpty(message: "Please enter password"))
    var password: String?
    
    @Validated(.nonEmpty(message: "Please enter new password"))
    var newPassword: String?
    
    var validatedProperties: [ValidatedProperty] {
        return [_password, _newPassword]
    }
    
    init(password: String, newPassword: String) {
        self.password = password
        self.newPassword = newPassword
    }
    
    init() { }
    
    static func validateNewPassword(_ newPassword: String) -> Result<String, ValidationError> {
        ChangePasswordDto()._newPassword.isValid(value: newPassword)
    }
    
    static func validatePassword(_ password: String) -> Result<String, ValidationError> {
        ChangePasswordDto()._password.isValid(value: password)
    }
}
