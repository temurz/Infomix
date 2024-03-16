//
//  CardConfigDao.swift
//  InfoMix
//
//  Created by Damir Asamatdinov on 26/01/22.
//  Copyright © 2022 InfoMix. All rights reserved.
//

import SwiftUI
import CoreData

class CardConfigDao {
    
    static let shared = CardConfigDao()
    
    func save(_ cardConfig: CardConfig) -> Bool {
        
        let entity: CardConfigEntity = CoreDataManager.shared.initManagedObject()
        entity.configCode = cardConfig.configCode
        let encoder = JSONEncoder()
        
        if let data = try? encoder.encode(cardConfig) {
            entity.configJson = String(data: data, encoding: .utf8)
        }
        
        return CoreDataManager.shared.saveContext()
    }
    
    func count() -> Int {
        return CoreDataManager.shared.count(entity: CardConfigEntity.self)
    }
    
    func delete(_ localUserId: Int32) -> Bool {
        guard let localUser: LocalUserEntity = CoreDataManager.shared.fetchObject(by: localUserId) else { return false }
        return CoreDataManager.shared.delete(localUser)
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
