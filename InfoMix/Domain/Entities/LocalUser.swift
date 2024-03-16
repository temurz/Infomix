//
//  LocalUser.swift
//  InfoMix
//
//  Created by Damir Asamatdinov on 26/01/22.
//  Copyright © 2022 InfoMix. All rights reserved.
//

import Foundation

struct LocalUser {
    var id: Int32?
    var certificate: String?
    var firstName: String?
    var lastName: String?
    var agentId: Int32?
    var serviceName: String?
    var lastActivation: Date?
    var token: String?
    var phone: String?
}

extension LocalUser {
    
    init(from entity: LocalUserEntity) {
        id = entity.id
        certificate = entity.certificate
        firstName = entity.firstName
        lastName = entity.lastName
        phone = entity.phone
        lastActivation = entity.lastActiveDate
        token = entity.token
        serviceName = entity.jobName
        agentId = entity.remoteId
    }
    
}
