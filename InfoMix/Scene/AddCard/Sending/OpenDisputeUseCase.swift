//
//  OpenDisputeUseCase.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 26/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

protocol OpenDisputeUseCaseType {
    func open(_ input: OpenDisputeInput) -> Observable<Dispute>
}

struct OpenDisputeUseCase: OpenDisputeUseCaseType, OpeningDispute {
    var disputeGateway: DisputeGatewayType
}

struct OpenDisputeInput {
    let serialCardId: Int
    let disputeCode: Int
    let disputeSubject: String
    let timelineId: String
    var disputeNote: String?
    
}
