//
//  API+ChangePassword.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 17/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Alamofire

extension API {
    func changePassword(_ input: ChangePasswordApiInput) -> Observable<Bool> {
        return success(input)
    }
    
    final class ChangePasswordApiInput: APIInput {
        init(password: String, newPassword: String) {
            
            let parameters: Parameters = [
                "password": password,
                "newPassword": newPassword
            ]
            
            super.init(urlString: API.Urls.changePassword,
                       parameters: parameters,
                       method: .post,
                       requireAccessToken: false)
            
        }
    }
    
}
