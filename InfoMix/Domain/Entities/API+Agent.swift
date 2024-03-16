//
//  API+Agent.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 14/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//



import Alamofire

extension API {
    func getAgentCurrentICU(_ input: GetAgentCurrentICUInput) -> Observable<ICU> {
        return request(input)
    }
    
    final class GetAgentCurrentICUInput: APIInput {
        init() {
           
            
            super.init(urlString: API.Urls.agentCurrentICU,
                       parameters: nil,
                       method: .get,
                       requireAccessToken: true)
            
        }
    }
    
}

