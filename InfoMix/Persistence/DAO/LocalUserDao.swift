//
//  LocalUserDao.swift
//  InfoMix
//
//  Created by Damir Asamatdinov on 25/01/22.
//  Copyright © 2022 InfoMix. All rights reserved.
//

import SwiftUI
import CoreData

class LocalUserDao {
    
    static let shared = LocalUserDao()
    
    func save(_ certificate: Certificate, _ token: String?) -> Bool {
        
        let localUser: LocalUserEntity = CoreDataManager.shared.initManagedObject()
        localUser.id = certificate.id ?? Int32.zero
        localUser.remoteId = certificate.master?.id ?? Int32.zero
        localUser.firstName = certificate.master?.firstName
        localUser.lastName = certificate.master?.lastName
        localUser.certificate = certificate.certificate
        localUser.token = token
        localUser.jobName = certificate.service?.name
        localUser.lastActiveDate = Date()
        
        return CoreDataManager.shared.saveContext()
    }
    
    func delete(_ localUserId: Int32) -> Bool {
        guard let localUser: LocalUserEntity = CoreDataManager.shared.fetchObject(by: localUserId) else { return false }
        return CoreDataManager.shared.delete(localUser)
    }
    
    
    func deleteByToken(_ token: String) -> Bool {
        
            let predicate = NSPredicate(format: "token == '\(token)'")
        guard let localUser: LocalUserEntity = CoreDataManager.shared.fetchObject(where: NSCompoundPredicate(andPredicateWithSubpredicates: [predicate])) else { return false }
        return CoreDataManager.shared.delete(localUser)
    }
    
    func count() -> Int {
        return CoreDataManager.shared.count(entity: LocalUserEntity.self)
    }
    
    func get(by localUserId: Int32) -> LocalUser? {
        guard let localUser: LocalUserEntity = CoreDataManager.shared.fetchObject(by: localUserId) else { return nil }
        let emotion = LocalUser(from: localUser)
        return emotion
    }
    
    func getAll(in alphabeticOrder: Bool = false) -> [LocalUser] {
        var sorters: [NSSortDescriptor]? = nil
        if alphabeticOrder {
            sorters = [ NSSortDescriptor(key: "lastActiveDate", ascending: true),  NSSortDescriptor(key: "firstName", ascending: true) ]
        }
        guard let locals: [LocalUserEntity] = CoreDataManager.shared.fecth(sorting: sorters) else { return [] }
        let certificates = locals.compactMap { (local) -> LocalUser? in LocalUser(from: local) }
        return certificates
    }
    
}
