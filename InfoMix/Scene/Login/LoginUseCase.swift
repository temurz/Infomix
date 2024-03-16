//
//  LoginUseCase.swift
//  CleanArchitecture
//
//  Created by Tuan Truong on 7/14/20.
//  Copyright © 2020 Tuan Truong. All rights reserved.
//

protocol LoginUseCaseType {
    func login(dto: LoginDto) -> Observable<Certificate>
    func getCardConfigs() -> Observable<[CardConfig]>
}

struct LoginUseCase: LoginUseCaseType, LoggingIn, GettingCardConfig {
    let authGateway: AuthGatewayType
    let cardConfigGateway: CardConfigGatewayType
}
