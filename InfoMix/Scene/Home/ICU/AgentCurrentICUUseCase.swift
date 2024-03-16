//
//  AgentCurrentICUUseCase.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 14/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//


protocol AgentCurrentICUUseCaseType{
    func getAgentCurrentICU() -> Observable<ICU>
}

struct AgentCurrentICUUseCase: AgentCurrentICUUseCaseType, GettingAgentCurrentICU {
    let agentGateway: AgentGatewayType
}
