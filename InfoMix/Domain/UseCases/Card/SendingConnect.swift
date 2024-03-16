//
//  SendingConnect.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 24/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//


import Combine

protocol SendingConnect {
    var cardGateway: CardGatewayType { get }
}

extension SendingConnect {
    func connect() -> Observable<Int> {
        cardGateway.connect()
    }
}

