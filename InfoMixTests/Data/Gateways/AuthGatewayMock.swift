//
//  AuthGatewayMock.swift
//  CleanArchitectureTests
//
//  Created by Tuan Truong on 8/11/20.
//  Copyright © 2020 Tuan Truong. All rights reserved.
//

@testable import CleanArchitecture
import UIKit
import Combine

final class AuthGatewayMock: AuthGatewayType {
    
    func getCurrentUser() -> Observable<Certificate> {
        return loginReturnValue.publisher.eraseToAnyPublisher()
    }
    
  
    
    
    // MARK: - login
    
    var loginCalled = false
    var loginReturnValue: Result<Certificate, Error> = .success((Certificate(id: 1, certificate: "0001", master: nil, service: nil, dailyLimitCard: 0, unreadNotification: 0, expired: false, blocked: false, needUpgradeConfig: false)))
    
    func login(dto: LoginDto) -> Observable<Certificate> {
        loginCalled = true
        return loginReturnValue.publisher.eraseToAnyPublisher()
    }
}
