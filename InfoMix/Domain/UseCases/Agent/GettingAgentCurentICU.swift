//
//  GettingAgentCurentICU.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 14/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import Combine

protocol GettingAgentCurrentICU {
    var agentGateway: AgentGatewayType { get }
}

extension GettingAgentCurrentICU {
    func getAgentCurrentICU() -> Observable<ICU> {
        agentGateway.getAgentCurrentICU()
    }
}

