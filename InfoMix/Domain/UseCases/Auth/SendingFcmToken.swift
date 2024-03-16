//
//  GettingFcmToken.swift
//  InfoMix
//
//  Created by Temur on 24/02/22.
//  Copyright © 2022 InfoMix. All rights reserved.
//

import Combine

protocol SendingFcmToken {
    var authGateway :  AuthGatewayType { get }
}

extension SendingFcmToken {
    func sendFcmToken(token: String) -> Observable<Bool> {
        return authGateway.sendFcmToken(token: token)
    }
}
