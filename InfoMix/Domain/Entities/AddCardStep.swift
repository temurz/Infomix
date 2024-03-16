//
//  CardStep.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 15/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import Foundation
import Then
import Localize_Swift

struct AddCardStep: Identifiable{
      var id: Int
      var autoComplete: Bool = true
      var items = [AddCardStepItem]()
      var titleUz: String?
      var titleRu: String?
      var cardConfig: CardConfig?
   
}


extension AddCardStep: Codable {
    enum CodingKeys: String, CodingKey {
        case autoComplete="autoComplete"
        case items = "items"
        case titleRu = "titleRu"
        case titleUz = "titleUz"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        autoComplete = try values.decodeIfPresent(Bool.self, forKey: .autoComplete) ?? false
        titleRu = try values.decodeIfPresent(String.self, forKey: .titleRu)
        titleUz = try values.decodeIfPresent(String.self, forKey: .titleUz)
        items = try values.decodeIfPresent([AddCardStepItem].self, forKey: .items) ?? [AddCardStepItem]()
        id = Int.random(in: 2...Int.max)
        
    }
    
    func encode(to encoder: Encoder) throws {
      // 2
      var container = encoder.container(keyedBy: CodingKeys.self)
      // 3
      try container.encode(autoComplete, forKey: .autoComplete)
      try container.encode(titleRu, forKey: .titleRu)
        try container.encode(titleUz, forKey: .titleUz)
      // 4
      try container.encode(items, forKey: .items)
    }
}



extension AddCardStep: Then, Equatable{
    static func == (lhs: AddCardStep, rhs: AddCardStep) -> Bool {
        return lhs.id == rhs.id
    }}

extension AddCardStep{
    static func none()-> AddCardStep{
        AddCardStep(id: -1)
    }
    
    static func confirmation(cardConfig: CardConfig) -> AddCardStep{
        AddCardStep(id: -2, cardConfig: cardConfig)
    }
    func titleLocalization() -> String?{
        let langCode = Localize.currentLanguage().lowercased()
        if langCode.starts(with: "uz") {
            return titleUz
        } else {
            return titleRu
        }
    }
    
    func enabledCloneButton(addCardStepItem: AddCardStepItem) -> Bool{
        if addCardStepItem.limit<=0 {
            return false
        }
        
        let itemId = addCardStepItem.originaltemId ?? addCardStepItem.id
        
        let cloneCount = items.filter { it in
            it.originaltemId == itemId
        }.count
        
        if cloneCount == 0{
            return true
        }
        
        if cloneCount >= addCardStepItem.limit {
            return false
        }
        
        let lastCloneIndex = items.lastIndex { it in
            it.originaltemId == itemId
        }
        
        return items.firstIndex(of: addCardStepItem)==lastCloneIndex
        
        
    }
    func isValid() -> Bool{
        
        self.items[0].skip || self.items[0].valueString.count > 0
    }
    
    func isPhoneValid() -> Bool{
        if items.count != 0 {
            return self.items[0].valueString.count == 12
        }else {
            return false
        }
    }
    
    func isNone()-> Bool {
        self.id == -1
    }
    func isConfirmation() -> Bool {
        self.id == -2
    }
    func isStep() -> Bool {
        !isNone() && !isConfirmation()
    }
    
    mutating func cloneStepItem(_ addCardStepItem: AddCardStepItem){
        
        if let index = items.lastIndex (of: addCardStepItem) {
            self.items.insert(addCardStepItem.clone(), at: index+1)
        }
    }
    
    mutating func removeCloneStepItem(_ addCardStepItem: AddCardStepItem){
        if addCardStepItem.originaltemId == nil {
            return
        }
        
        if let index = items.lastIndex(of: addCardStepItem){
            self.items.remove(at: index)
        }
    }
}
