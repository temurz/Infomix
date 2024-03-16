//
//  API+OpenDispute.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 26/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import Alamofire
import Combine

extension API {
    
    func openDispute(_ input: OpenDisputeAPIInput) -> Observable<Dispute> {
        return request(input)
    }
    
    final class OpenDisputeAPIInput: APIInput {
        init( serialCardId: Int,disputeCode: Int, disputeSubject:String, disputeNote:String?){
            var parameters: Parameters = [
                "id": serialCardId,
                "disputeCode":disputeCode,
                "disputeSubject":disputeSubject
            ]
            if let disputeNote = disputeNote {
                parameters["disputeNote"] = disputeNote
            }
            super.init(urlString: "\(NetworkManager.shared.baseUrl)/dispute/open",
                       parameters: parameters,
                       method: .post,
                       requireAccessToken: true)
            
            self.headers = [
                "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8"
            ]
            self.encoding = URLEncoding.httpBody
        }
    }
    
}


