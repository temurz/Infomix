//
//  CardStepItem.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 15/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//
import Foundation
import UIKit
import Then
import Localize_Swift
import Alamofire

enum AddCardStepItemType: String{
    case EDIT_TEXT,
      EDIT_TEXT_MULTILINE,
      EDIT_TEXT_INTEGER,
      EDIT_TEXT_FLOAT,
      EDIT_TEXT_BARCODE,
      EDIT_TEXT_PHONE,
      CHECK_BOX,
      CHOOSE_DATE,
      CHOOSE_TIME,
      CHOOSE_DATE_AND_TIME,
      CHOOSE_PHOTO,
      ADD_ONE_MORE_ITEM
}


struct AddCardStepItem: Identifiable{
    var id: String = UUID().uuidString
    var titleRu: String? = nil
    var value: Any? = nil
    var imageValue : Data? = nil
    var remoteName: String? = nil
    var type: AddCardStepItemType = AddCardStepItemType.EDIT_TEXT_PHONE
    var minLength: Int = 0
    var maxLength: Int = 0
    var cardStepId: Int? = 0
    var hasValidationError: Bool = false
    var titleUz: String? = nil
    var title: String? = nil
    var skip: Bool = false
    var productionCode: String?
    var limit: Int = 0
    var editable = false
    var valueString: String = ""
    var originaltemId: String? = nil
    var isSended: Bool = false
    
}
extension AddCardStepItem :Then, Equatable {
    static func == (lhs: AddCardStepItem, rhs: AddCardStepItem) -> Bool {
        return lhs.id == rhs.id
    }
}


extension AddCardStepItem: Codable {
    enum CodingKeys: String, CodingKey {
        case remoteName="remoteName"
        case type="type"
        case minLength="minLength"
        case maxLength="maxLength"
        case skip="skip"
        case productionCode = "productionCode"
        case limit = "limit"
        case editable = "editable"
        case titleRu = "titleRu"
        case titleUz = "titleUz"
        case title = "title"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        remoteName = try values.decodeIfPresent(String.self, forKey: .remoteName)
        titleRu = try values.decodeIfPresent(String.self, forKey: .titleRu)
        titleUz = try values.decodeIfPresent(String.self, forKey: .titleUz)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        productionCode = try values.decodeIfPresent(String.self, forKey: .productionCode)
        
        let typeString  = try values.decodeIfPresent(String.self, forKey: .type) ?? AddCardStepItemType.EDIT_TEXT.rawValue
        type  = AddCardStepItemType.init(rawValue: typeString) ?? AddCardStepItemType.EDIT_TEXT
        
        
        minLength = try values.decodeIfPresent(Int.self, forKey: .minLength) ?? 0
        maxLength = try values.decodeIfPresent(Int.self, forKey: .maxLength) ?? 0
        limit = try values.decodeIfPresent(Int.self, forKey: .limit) ?? 0
        
        skip = try values.decodeIfPresent(Bool.self, forKey: .skip) ?? false
        editable = try values.decodeIfPresent(Bool.self, forKey: .editable) ?? false
    }
    
    func encode(to encoder: Encoder) throws {
      // 2
      var container = encoder.container(keyedBy: CodingKeys.self)
      // 3
      try container.encode(remoteName, forKey: .remoteName)
      try container.encode(titleRu, forKey: .titleRu)
        try container.encode(productionCode, forKey: .productionCode)
        try container.encode(titleUz, forKey: .titleUz)
        try container.encode(type.rawValue, forKey: .type)
        try container.encode(minLength, forKey: .minLength)
        try container.encode(maxLength, forKey: .maxLength)
        try container.encode(limit, forKey: .limit)
        try container.encode(skip, forKey: .skip)
        try container.encode(editable, forKey: .editable)
    }
    
    
}


extension AddCardStepItem{
    func titleLocalization() -> String{
        var localizationTitle = self.titleRu
        let langCode = Localize.currentLanguage().lowercased()
        if   langCode.starts(with: "uz") {
            localizationTitle =  self.titleUz
        }
        
        return localizationTitle ?? self.title ?? ""
    }
    
    func keyboardPad() -> UIKeyboardType {
        switch type {
        case .EDIT_TEXT_FLOAT: return .decimalPad
        case .EDIT_TEXT_INTEGER: return .numberPad
        default: return .default
        }
    }
    
    func clone() -> AddCardStepItem{
        var clone = AddCardStepItem()
        clone.type = self.type
        clone.titleRu = self.titleRu
        clone.titleUz = self.titleUz
        clone.value = self.value
        clone.remoteName = self.remoteName
        clone.minLength = self.minLength
        clone.maxLength = self.maxLength
        clone.cardStepId = self.cardStepId
        clone.hasValidationError = self.hasValidationError
        clone.skip = self.skip
        clone.productionCode = self.productionCode
        clone.limit = self.limit
        clone.editable = self.editable
        clone.valueString = self.valueString
        clone.originaltemId = self.originaltemId ?? self.id
        
        return clone
    }
    
    mutating func changeValue(value: String){
        self.valueString = value
    }
    
    func valid() -> Bool{
        if(self.skip) {
            return true
        }
        
        switch(self.type){
        case .EDIT_TEXT_PHONE:
            return valueString.count == 12
        case .EDIT_TEXT:
            return valueString.count >= minLength && valueString.count <= maxLength
        case .EDIT_TEXT_MULTILINE:
            return true
        case .EDIT_TEXT_INTEGER:
            return true
        case .EDIT_TEXT_FLOAT:
            return true
        case .EDIT_TEXT_BARCODE:
            return valueString.count >= minLength && valueString.count <= maxLength
        case .CHECK_BOX:
            return true
        case .CHOOSE_DATE:
            return true
        case .CHOOSE_TIME:
            return true
        case .CHOOSE_DATE_AND_TIME:
            return true
        case .CHOOSE_PHOTO:
            return imageValue != nil
        case .ADD_ONE_MORE_ITEM:
            return true
        }
    }
    
    mutating func sended(){
        self.isSended = true
    }
    
}
