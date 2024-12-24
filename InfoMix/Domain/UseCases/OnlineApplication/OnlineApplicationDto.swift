//
//  OnlineApplicationDto.swift
//  InfoMix
//
//  Created by Temur on 25/03/22.
//  Copyright © 2022 InfoMix. All rights reserved.
//

import Combine
import Foundation
import ValidatedPropertyKit
import Dto

struct OnlineApplicationDto : Dto{

    @Validated(.nonEmpty(message: "Please choose a service".localized()))
    var configCode: String?

    @Validated(.nonEmpty(message: "Please enter your name".localized()))
    var name: String?

    @Validated(.nonEmpty(message: "Please enter your surname".localized()))
    var surname: String?

    @Validated(.nonEmpty(message: "Please enter your father's name".localized()))
    var fathersname : String?

    @Validated(.notPhoneNumber(message: "Please enter your phone number".localized()))
    var phoneNumber : String?

    @Validated(.checkAge(message: "You are under 18, you are not allowed".localized()))
    var age : Date?

    @Validated(.idValid(message: "Please choose your city".localized()))
    var cityId : Int?
    @Validated(.idValid(message: "Please choose your market".localized()))
    var marketId : Int?

    @Validated(.nonEmpty(message: "Please fill the field".localized()))
    var aboutMe : String?

    @Validated(.nonEmpty(message: "Please fill the field".localized()))
    var shopNumber : String?

    @Validated(.hasImageData(message: "Please choose a photo".localized()))
    var photoIdCard : Data?

    @Validated(.hasImageData(message: "Please choose a photo".localized()))
    var photoSelfie : Data?

    var validatedProperties: [ValidatedProperty] {
        return [_name, _surname, _fathersname, _phoneNumber, _age, _cityId, _configCode, _marketId, _aboutMe, _shopNumber, _photoIdCard, _photoSelfie]
    }

    init(username: String, surname: String, fathersname: String, phoneNumber: String, age: Date, cityId: Int, configCode: String, aboutMe: String, marketId: Int, shopNumber: String, photoIdCard: Data, photoSelfie: Data){
        self.name = username
        self.surname = surname
        self.fathersname = fathersname
        self.phoneNumber = phoneNumber
        self.age = age
        self.cityId = cityId
        self.configCode = configCode
        self.aboutMe = aboutMe
        self.marketId = marketId
        self.shopNumber = shopNumber
        self.photoIdCard = photoIdCard
        self.photoSelfie = photoSelfie
    }
    init() { }

    static func validateName(_ username: String) -> Result<String, ValidationError> {
        OnlineApplicationDto()._name.isValid(value: username)
    }

    static func validateConfigCode(_ configCode: String) -> Result<String, ValidationError>{
        OnlineApplicationDto()._configCode.isValid(value: configCode)
    }

    static func validateSurname(_ surname: String) -> Result<String, ValidationError> {
        OnlineApplicationDto()._surname.isValid(value: surname)
    }

    static func validateFathersname(_ fathersname: String) -> Result<String, ValidationError> {
        OnlineApplicationDto()._fathersname.isValid(value: fathersname)
    }

    static func validatePhoneNumber(_ phoneNumber: String) -> Result<String, ValidationError> {
        OnlineApplicationDto()._phoneNumber.isValid(value: phoneNumber)
    }

    static func validateAge(_ age: Date) -> Result<Date, ValidationError> {
        OnlineApplicationDto()._age.isValid(value: age)
    }

    static func validateCity(_ cityId: Int) -> Result<Int, ValidationError> {
        OnlineApplicationDto()._cityId.isValid(value: cityId)
    }
    static func validateMarket(_ marketId: Int) -> Result<Int, ValidationError>{
        OnlineApplicationDto()._marketId.isValid(value: marketId)
    }
    static func validateAboutMe(_ aboutMe: String) -> Result<String,ValidationError>{
        OnlineApplicationDto()._aboutMe.isValid(value: aboutMe)
    }
    static func validateShopNumber(_ shopNumber: String) -> Result<String,ValidationError>{
        OnlineApplicationDto()._shopNumber.isValid(value: shopNumber)
    }

    static func validatePhotoIdCard(_ photoIdCard: Data) -> Result<Data,ValidationError>{
        OnlineApplicationDto()._photoIdCard.isValid(value: photoIdCard)
    }

    static func validatePhotoSelfie(_ photoSelfie: Data) -> Result<Data,ValidationError>{
        OnlineApplicationDto()._photoSelfie.isValid(value: photoSelfie)
    }
}
