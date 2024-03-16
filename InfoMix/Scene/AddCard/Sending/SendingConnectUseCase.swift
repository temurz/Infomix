//
//  SendingConnectUseCase.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 23/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

protocol SendingConnectUseCaseType {
    func connect() -> Observable<Int>
}

struct SendingConnectUseCase: SendingConnectUseCaseType, SendingConnect {
    let cardGateway: CardGatewayType
  
}
