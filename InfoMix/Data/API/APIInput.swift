//
//  APIInput.swift
//  CleanArchitecture
//
//  Created by Tuan Truong on 7/31/20.
//  Copyright © 2020 Tuan Truong. All rights reserved.
//

import Alamofire
import Foundation

class APIInput: APIInputBase {  // swiftlint:disable:this final_class
    override init(urlString: String,
                  parameters: Parameters?,
                  method: HTTPMethod,
                  requireAccessToken: Bool,
                  encoding: ParameterEncoding? = nil) {
        super.init(urlString: urlString,
                   parameters: parameters,
                   method: method,
                   requireAccessToken: requireAccessToken,
                   encoding: encoding
        )
        self.headers = [
            "Content-Type": "application/json; charset=utf-8",
            "Accept": "application/json"
        ]
        
        self.token = UserDefaults.standard.string(forKey: "token")
    }
}
