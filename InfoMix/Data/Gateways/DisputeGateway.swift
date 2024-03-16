//
//  DisputeGateway.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 26/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import Combine
import Foundation

protocol DisputeGatewayType {
    func openDispute(serialCardId: Int, disputeCode: Int, disputeSubject: String, disputeNote: String?) -> Observable<Dispute>
}

struct DisputeGateway: DisputeGatewayType {
    
 
    func openDispute(serialCardId: Int, disputeCode: Int, disputeSubject: String, disputeNote: String?) -> Observable<Dispute> {
        let input = API.OpenDisputeAPIInput(serialCardId: serialCardId, disputeCode: disputeCode, disputeSubject: disputeSubject, disputeNote: disputeNote)
        
        return API.shared.openDispute(input)
    }
    
}

struct PreviewDisputeGateway: DisputeGatewayType {
    
       func openDispute(serialCardId: Int, disputeCode: Int, disputeSubject: String, disputeNote: String?) -> Observable<Dispute> {
        Future<Dispute, Error> { promise in
            promise(.success(Dispute()))
        }
        .eraseToAnyPublisher()
    }
    
}


