//
//  ChangingPassword.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 17/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Combine

protocol ChangingPassword {
    var authGateway :  AuthGatewayType { get }
}

extension ChangingPassword {
    func changePassword(dto: ChangePasswordDto) -> Observable<Bool> {
        return authGateway.changePassword(password: dto.password ?? "", newPassword: dto.newPassword ?? "")
    }
}
