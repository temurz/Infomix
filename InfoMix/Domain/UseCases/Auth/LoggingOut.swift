//
//  LoggingIn.swift
//  CleanArchitecture
//
//  Created by Tuan Truong on 7/29/20.
//  Copyright © 2020 Tuan Truong. All rights reserved.
//

import Combine
import Foundation

protocol LoggingOut {
    var authGateway: AuthGatewayType { get }
}

extension LoggingOut {
    func logout() -> Observable<Int> {
       
        return authGateway.logout()
    }
}
