//
//  LocalUserGateway.swift
//  InfoMix
//
//  Created by Damir Asamatdinov on 25/01/22.
//  Copyright © 2022 InfoMix. All rights reserved.
//


import Combine
import Foundation

protocol LocalUserGatewayType {

    func getAllLocalUser() -> Observable<[LocalUser]>
}


struct LocalUserGateway: LocalUserGatewayType {
    func getAllLocalUser() -> Observable<[LocalUser]> {
        Future<[LocalUser], Error> { promise in
    
            let certificates = LocalUserDao.shared.getAll(in: true)
            print(certificates)
            promise(.success(certificates))
        }
        .eraseToAnyPublisher()
    }
    
   
}
