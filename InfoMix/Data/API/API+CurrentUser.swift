//
//  API+CurrentUser.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 13/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import Alamofire

extension API {
    func getCurrentUser(_ input: CurrentUserInput) -> Observable<Certificate> {
        return request(input)
    }
    
    final class CurrentUserInput: APIInput {
        init() {
            
            super.init(urlString: API.Urls.currentUser,
                       parameters: nil,
                       method: .get,
                       requireAccessToken: false)
            
        }
    }
    
}

