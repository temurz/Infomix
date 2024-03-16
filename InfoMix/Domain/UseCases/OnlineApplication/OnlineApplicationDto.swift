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
    
    @Validated(.notCity(message: "Please choose your city".localized()))
    var isCityChosen : Bool?
    
    var validatedProperties: [ValidatedProperty] {
        return [_name, _surname, _fathersname, _phoneNumber, _age, _isCityChosen, _configCode]
    }
    
    init(username: String, password: String, fathersname: String, phoneNumber: String, age: Date, isCityChosen: Bool, configCode: String){
        self.name = username
        self.surname = password
        self.fathersname = fathersname
        self.phoneNumber = phoneNumber
        self.age = age
        self.isCityChosen = isCityChosen
        self.configCode = configCode
        
    }
    init() { }
    
    static func validateName(_ username: String) -> Result<String, ValidationError> {
        OnlineApplicationDto()._name.isValid(value: username)
    }
    
    static func validateConfigCode(_ configCode: String) -> Result<String, ValidationError>{
        OnlineApplicationDto()._configCode.isValid(value: configCode)
    }
    
    static func validateSurname(_ password: String) -> Result<String, ValidationError> {
        OnlineApplicationDto()._surname.isValid(value: password)
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
    
    static func validateCity(_ isCityChosen: Bool) -> Result<Bool, ValidationError> {
        OnlineApplicationDto()._isCityChosen.isValid(value: isCityChosen)
    }
}
