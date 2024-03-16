//
//  LogoutUseCase.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 18/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Combine

protocol LogoutUseCaseType {
    func logout() -> Observable<Int>
}

struct LogoutUseCase: LogoutUseCaseType, LoggingOut {
    let authGateway: AuthGatewayType
    
}
