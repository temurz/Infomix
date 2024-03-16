//
//  API+Login.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 10/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//
import Alamofire
import UIKit

// MARK: - GetRepoList
extension API {
    func login(_ input: LoginInput) -> Observable<LoginOutput> {
        return request(input)
    }
    
    final class LoginInput: APIInput {
        init(dto: LoginDto) {
            let params: Parameters = [
                "certificate": dto.username ?? "",
                "password": dto.password ?? "",
                "configCode":dto.configCode ?? "",
                "deviceId": UIDevice.current.identifierForVendor?.uuidString ?? "",
                "deviceName": UIDevice.current.name
                
            ]
            
            super.init(urlString: API.Urls.login,
                       parameters: params,
                       method: .post,
                       requireAccessToken: false)
            
        }
    }
    
    final class LoginOutput: Decodable {
        private(set) var certificate: Certificate?
        private(set) var token: String?
        
        // swiftlint:disable:next nesting
        private enum CodingKeys: String, CodingKey {
            case certificate, token
        }
    }
}
