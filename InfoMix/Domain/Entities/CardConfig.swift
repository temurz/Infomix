//
//  CardConfig.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 22/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import Foundation

struct TitleTranslation: Codable {
    let value: String?
    let locale: String?
}

struct ResumeField: Codable {
    let field: String?
    let required: Bool?
    let enabled: Bool?

}

struct CardConfig : Identifiable {
    
    
    static var shared = CardConfig()
    
    var id : Int = 0 
    var configCode: String
    var configVersion: String?
    var canRequest = false
    var showConfirmation: Bool = false
    var titleRu: String?
    var titleUz: String?
    var titleTranslations: TitleTranslation?
    var title: String = ""
    var minExchange: Int = 0
    var hasPayment = false
    var steps = [AddCardStep]()
    var remoteUrl: String?
    var hasShop = false
    var iconUrl: String?
    var addInformationResume: String?
    var installedDate: Date = Date()
    var longitude: Double? = nil
    var latitude: Double? = nil
    
    var getCityType: String?
    var showStock: Bool?
    var resumeFields: Bool?
    
}


extension CardConfig: Codable {
    enum CodingKeys: String, CodingKey {
        case id  = "id"
        case configCode="configCode"
        case configVersion = "configVersion"
        case canRequest = "canRequest"
        case showConfirmation = "showConfirmation"
        case titleRu = "titleRu"
        case titleUz = "titleUz"
        case title = "title"
        case minExchange = "minExchange"
        case hasPayment = "hasPayment"
        case remoteUrl = "remoteUrl"
        case hasShop = "hasShop"
        case iconUrl = "iconUrl"
        case steps = "steps"
        case addInformationResume = "addInformationResume"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? 0
        configCode = try values.decodeIfPresent(String.self, forKey: .configCode) ?? ""
        configVersion = try values.decodeIfPresent(String.self, forKey: .configVersion)
        showConfirmation = try values.decodeIfPresent(Bool.self, forKey: .showConfirmation) ?? false
        canRequest = try values.decodeIfPresent(Bool.self, forKey: .canRequest) ?? false
        titleRu = try values.decodeIfPresent(String.self, forKey: .titleRu)
        titleUz = try values.decodeIfPresent(String.self, forKey: .titleUz)
        title = try values.decode(String.self, forKey: .title)
        minExchange = try values.decodeIfPresent(Int.self, forKey: .minExchange) ?? 0
        hasPayment = try values.decodeIfPresent(Bool.self, forKey: .hasPayment) ?? false
        hasShop = try values.decodeIfPresent(Bool.self, forKey: .hasShop) ?? false
        remoteUrl = try values.decodeIfPresent(String.self, forKey: .remoteUrl)
        iconUrl = try values.decodeIfPresent(String.self, forKey: .iconUrl)
        steps = try values.decodeIfPresent([AddCardStep].self, forKey: .steps) ?? [AddCardStep]()
        addInformationResume = try values.decodeIfPresent(String.self, forKey: .addInformationResume)
    }
    
    init() {
        id = 0
        configCode = ""
        configVersion = ""
        canRequest = false
        showConfirmation = false
        titleRu = ""
        titleUz = ""
        title = ""
        minExchange = 0
        hasPayment = false
        steps = [AddCardStep]()
        remoteUrl = ""
        hasShop = false
        iconUrl = ""
        installedDate = Date()
        longitude = nil
        latitude = nil
        addInformationResume = ""
    }
    
    func encode(to encoder: Encoder) throws {
      // 2
      var container = encoder.container(keyedBy: CodingKeys.self)
      // 3
      try container.encode(configCode, forKey: .configCode)
      try container.encode(configVersion, forKey: .configVersion)
        try container.encode(showConfirmation, forKey: .showConfirmation)
        try container.encode(canRequest, forKey: .canRequest)
        try container.encode(titleRu, forKey: .titleRu)
        try container.encode(titleUz, forKey: .titleUz)
        try container.encode(title, forKey: .title)
        try container.encode(minExchange, forKey: .minExchange)
        try container.encode(hasPayment, forKey: .hasPayment)
        try container.encode(hasShop, forKey: .hasShop)
        try container.encode(remoteUrl, forKey: .remoteUrl)
        try container.encode(iconUrl, forKey: .iconUrl)
      // 4
      try container.encode(steps, forKey: .steps)
        try container.encode(addInformationResume, forKey: .addInformationResume)
    }
}


extension CardConfig {
    
    mutating func update(cardStep: AddCardStep){
        let index = indexStep(of: cardStep)
        if hasStepIndex(index: index) {
            steps.remove(at: index)
            steps.insert(cardStep, at: index)
        }
    }
    
    
    func getStep(currentIndex: Int) -> AddCardStep {
        
        return hasStepIndex(index: currentIndex) ? steps[currentIndex] : AddCardStep.none()
    
    }
    
    func startIndex()-> Int {
        steps.startIndex
    }
    
    func endIndex() -> Int {
        steps.endIndex
    }
    
    func nextIndex(currentIndex: Int) -> Int? {
        if currentIndex == steps.endIndex - 1 { return nil }
       return hasStepIndex(index: currentIndex) ?
        steps.index(after: currentIndex) : nil
    }
    
    func prevIndex (currentIndex: Int) -> Int? {
        if currentIndex == steps.startIndex { return nil }
        
        return  hasStepIndex(index: currentIndex) ? steps.index(before: currentIndex) : nil
    }
    
    func indexStep(of: AddCardStep) -> Int{
        return steps.firstIndex(of: of) ?? -1
    }
    
    func hasStepIndex(index: Int) -> Bool{
        return index >= steps.startIndex  && index < steps.endIndex
    }
    
    func serialNumbers(separator: String) -> String {
        return steps.flatMap { it in
            it.items
        }.filter { item in
            item.type == .EDIT_TEXT_BARCODE
        }.map { item in
            item.valueString
        }.joined(separator: separator)
    }
    
    func additionalData()->String{
        let phone =  steps.flatMap{ it in
            it.items
        }.filter{ item in
            item.type == .EDIT_TEXT_PHONE
        }.map{ item in
            "\(item.titleLocalization()): \(item.valueString)"
        }.joined(separator: "\n")
        
        
        let installed = "Installed date: \(self.installedDate.toApiFormat())"
        return "\(phone)\n\(installed)"
    }
    
    func getPhones() -> String {
        return  steps.flatMap{ it in
            it.items
        }.first{ item in
            item.type == .EDIT_TEXT_PHONE
        }?.valueString ?? ""
    }
}
