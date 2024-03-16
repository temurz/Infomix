//
//  GettingCurrentUser.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 13/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import Combine

protocol GettingCurrentUser {
    var authGateway: AuthGatewayType { get }
}

extension GettingCurrentUser {
    func getCurrentUser() -> Observable<Certificate> {
        return authGateway.getCurrentUser()
    }
}

