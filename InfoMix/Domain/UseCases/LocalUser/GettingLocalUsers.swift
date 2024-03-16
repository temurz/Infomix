//
//  GettingLocalUsers.swift
//  InfoMix
//
//  Created by Damir Asamatdinov on 25/01/22.
//  Copyright © 2022 InfoMix. All rights reserved.
//


import Combine

protocol GettingLocalUsers {
    var localUserGateway: LocalUserGatewayType { get }
}

extension GettingLocalUsers {
    func getLocalUsers() -> Observable<[LocalUser]> {
        return localUserGateway.getAllLocalUser()
    }
}
