//
//  AgentGateway.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 14/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import Combine

protocol AgentGatewayType {
    func getAgentCurrentICU() -> Observable<ICU>
}


struct AgentGateway: AgentGatewayType {
    func getAgentCurrentICU() -> Observable<ICU> {
        let input = API.GetAgentCurrentICUInput()
        
        return API.shared.getAgentCurrentICU(input)
            .eraseToAnyPublisher()
    }
}

struct PreviewAgentGateway: AgentGatewayType {
    func getAgentCurrentICU() -> Observable<ICU> {
        Future<ICU, Error> { promise in
    
            promise(.success(ICU(balance: 10.0)))
        }
        .eraseToAnyPublisher()
    }
    
}
