//
//  OpeningDispute.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 26/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import Combine
import Foundation

protocol OpeningDispute {
    var disputeGateway: DisputeGatewayType { get }
}

extension OpeningDispute {
    func open(_ input: OpenDisputeInput) -> Observable<Dispute> {
        disputeGateway.openDispute(serialCardId: input.serialCardId, disputeCode: input.disputeCode, disputeSubject: input.disputeSubject, disputeNote: input.disputeNote)
    }
}

