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

struct CardConfig : Identifiable {
    
    
    static var shared = CardConfig()

    var id : Int = 0
    var configCode: String
    var configVersion: String?
    var canRequest = false
    var showConfirmation: Bool = false
    var title: String?
    var titleTranslations: [TitleTranslation]? = []
    var titleRu: String?
    var titleUz: String?
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
    var resumeFields : [ResumeField]? = nil
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
        case minExchange = "minExchange"
        case hasPayment = "hasPayment"
        case remoteUrl = "remoteUrl"
        case hasShop = "hasShop"
        case iconUrl = "iconUrl"
        case steps = "steps"
        case addInformationResume = "addInformationResume"
        case resumeFields = "resumeFields"
        case title = "title"
        case titleTranslations = "titleTranslations"
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
        minExchange = try values.decodeIfPresent(Int.self, forKey: .minExchange) ?? 0
        hasPayment = try values.decodeIfPresent(Bool.self, forKey: .hasPayment) ?? false
        hasShop = try values.decodeIfPresent(Bool.self, forKey: .hasShop) ?? false
        remoteUrl = try values.decodeIfPresent(String.self, forKey: .remoteUrl)
        iconUrl = try values.decodeIfPresent(String.self, forKey: .iconUrl)
        steps = try values.decodeIfPresent([AddCardStep].self, forKey: .steps) ?? [AddCardStep]()
        addInformationResume = try values.decodeIfPresent(String.self, forKey: .addInformationResume)
        resumeFields = try values.decodeIfPresent([ResumeField].self, forKey: .resumeFields)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        titleTranslations = try values.decodeIfPresent([TitleTranslation].self, forKey: .titleTranslations) ?? [TitleTranslation]()
    }

    init() {
        id = 0
        configCode = ""
        configVersion = ""
        canRequest = false
        showConfirmation = false
        titleRu = ""
        titleUz = ""
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
        resumeFields = nil
        title = ""
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
        try container.encode(minExchange, forKey: .minExchange)
        try container.encode(hasPayment, forKey: .hasPayment)
        try container.encode(hasShop, forKey: .hasShop)
        try container.encode(remoteUrl, forKey: .remoteUrl)
        try container.encode(iconUrl, forKey: .iconUrl)
        try container.encode(title, forKey: .title)
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

    func serialNumbers() -> [SerialNumberInput] {
        return steps.flatMap { it in
            it.items
        }.filter { item in
            item.type == .EDIT_TEXT_BARCODE
        }.map { item in
            return SerialNumberInput(serialNumber: item.valueString)
        }
    }

    func serialNumberText(separator: String) -> String {
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
        }.map{ item in
            "\(item.titleLocalization()): \(item.valueString)"
        }.joined(separator: "\n")


        let installed = "Installed date: \(self.installedDate.toApiFormat())"
        return "\(phone)\n\(installed)"
    }

    func getAdditionalData()->[AddCardStepItem] {
        return  steps.flatMap{ it in
                   it.items
        }.filter{item in
            item.type != .ADD_ONE_MORE_ITEM && item.type != .CHOOSE_PHOTO
            && item.type != .EDIT_TEXT_BARCODE
        }
    }

    func getPhones() -> String {
        return  steps.flatMap{ it in
            it.items
        }.first{ item in
            item.type == .EDIT_TEXT_PHONE
        }?.valueString ?? ""
    }

    func getNextImageData(sendingImage: [String] ) -> AddCardStepItem? {
        return steps.flatMap{ it in
            it.items
        }.first{ item in
            item.type == .CHOOSE_PHOTO  && item.imageValue != nil && !sendingImage.contains(item.id)
        }
    }

    func hasResumeField(fieldName: String) -> Bool {
        return self.resumeFields?.contains(where: { it in
            return it.field == fieldName && it.enabled
        }) ?? false
    }

}
