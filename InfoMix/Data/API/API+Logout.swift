//
//  API+Logout.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 18/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//
import Alamofire


extension API {
    func logout(_ input: LogoutInput) -> Observable<Bool> {
        return success(input)
    }
    
    final class LogoutInput: APIInput {
        init() {
           
            super.init(urlString: API.Urls.logout,
                       parameters: nil,
                       method: .post,
                       requireAccessToken: false)
            
        }
    }
}
