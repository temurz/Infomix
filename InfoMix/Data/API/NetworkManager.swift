//
//  NetworkManager.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 07/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Alamofire
import Foundation
import MapKit

final class NetworkManager {
    
    static var shared = NetworkManager(baseUrl: "")
    
    let baseUrl: String
    let token: String?
    
    init(baseUrl: String){
        self.baseUrl = baseUrl
        self.token = nil
    }
    
}
