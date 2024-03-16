//
//  OnlineApplicationViewModel.swift.swift
//  InfoMix
//
//  Created by Temur on 07/03/22.
//  Copyright © 2022 InfoMix. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI
import Combine

public enum BottomSheetPositionBirthday: CGFloat, CaseIterable {
    case middle = 0.8, hidden = 0
}

struct OnlineApplicationViewModel{
    var useCase : OnlineApplicationUseCaseType
}

extension OnlineApplicationViewModel : ViewModel{
    
    
    final class Input : ObservableObject{
        @Published var name = ""
        @Published var surname = ""
        @Published var fathersname = ""
        @Published var phoneNumber = ""
        @Published var age = Date()
        @Published var configCode = ""
        let loadOnlineApplicationTrigger: Driver<Void>
        let loadInputDataTrigger: Driver<Void>
        let showBirthdayCalendarTrigger : Driver<Void>
        let chooseCityTrigger : Driver<Void>
        let loadCitiesTrigger : Driver<Void>
        let reloadCitiesTrigger : Driver<Void>
        let getConfigsTrigger : Driver<Void>
        init(showCalendar: Driver<Void>, loadOnlineApplicationTrigger: Driver<Void>,chooseCityTrigger: Driver<Void>, loadCitiesTrigger: Driver<Void>, reloadCitiesTrigger: Driver<Void>, loadInputTrigger: Driver<Void>, getConfigsTrigger: Driver<Void>){
            self.showBirthdayCalendarTrigger = showCalendar
            self.loadOnlineApplicationTrigger = loadOnlineApplicationTrigger
            self.chooseCityTrigger = chooseCityTrigger
            self.loadCitiesTrigger = loadCitiesTrigger
            self.reloadCitiesTrigger = reloadCitiesTrigger
            self.loadInputDataTrigger = loadInputTrigger
            self.getConfigsTrigger = getConfigsTrigger
        }
    }
    
    final class Output : ObservableObject {
        @Published var birthday = Date()
        @Published var city = "City".localized()
        @Published var isCityChosen = false
        @Published var resume = "Choose resume".localized()
        @Published var bottomSheetPosition: BottomSheetPositionBirthday = .hidden
        @Published var cities = [CityItemViewModel]()
        @Published var nameValidationMessage = ""
        @Published var surnameValidationMessage = ""
        @Published var fathersnameValidationMessage = ""
        @Published var phoneNumberValidationMessage = ""
        @Published var ageValidationMessage = ""
        @Published var cityValidationMessage = ""
        @Published var isLoadEnabled1 = false
        @Published var isLoadEnabled2 = false
        @Published var isLoadEnabled3 = false
        @Published var configs = [CardConfig]()
        @Published var service = "Choose a service"
        @Published var chosenConfig = CardConfig()
        @Published var configCodeValidationMessage = ""
        
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        
        let output = Output()
        
        let nameValidation = Publishers
            .CombineLatest(input.$name, input.loadInputDataTrigger)
            .map {$0.0}
            .map(OnlineApplicationDto.validateName(_:))
        
        nameValidation
            .asDriver()
            .map{ $0.message}
            .assign(to: \.nameValidationMessage, on: output)
            .store(in: cancelBag)
        
        let surnameValidation = Publishers
            .CombineLatest(input.$surname, input.loadInputDataTrigger)
            .map {$0.0}
            .map (OnlineApplicationDto.validateSurname(_:))
        
        surnameValidation
            .asDriver()
            .map { $0.message }
            .assign(to: \.surnameValidationMessage, on: output)
            .store(in: cancelBag)
        
        let fathersnameValidation = Publishers
            .CombineLatest(input.$fathersname, input.loadInputDataTrigger)
            .map {$0.0}
            .map (OnlineApplicationDto.validateFathersname(_:))
        
        fathersnameValidation
            .asDriver()
            .map {$0.message}
            .assign(to: \.fathersnameValidationMessage,on: output)
            .store(in: cancelBag)
        
        let phoneNumberValidation = Publishers
            .CombineLatest(input.$phoneNumber, input.loadInputDataTrigger)
            .map {$0.0}
            .map (OnlineApplicationDto.validatePhoneNumber(_:))
        
        phoneNumberValidation
            .asDriver()
            .map {$0.message}
            .assign(to: \.phoneNumberValidationMessage, on: output)
            .store(in: cancelBag)
        
        let ageValidation = Publishers
            .CombineLatest(output.$birthday, input.loadInputDataTrigger)
            .map {$0.0}
            .map (OnlineApplicationDto.validateAge(_:))
        
        ageValidation
            .asDriver()
            .map {$0.message}
            .assign(to: \.ageValidationMessage, on: output)
            .store(in: cancelBag)
        
        let cityValidation = Publishers
            .CombineLatest(output.$isCityChosen, input.loadInputDataTrigger)
            .map {$0.0}
            .map (OnlineApplicationDto.validateCity(_:))
        
        cityValidation
            .asDriver()
            .map {$0.message}
            .assign(to: \.cityValidationMessage, on: output)
            .store(in: cancelBag)
        
        let configCodeValidation = Publishers
            .CombineLatest(input.$configCode, input.loadInputDataTrigger)
            .map {$0.0}
            .map (OnlineApplicationDto.validateConfigCode(_:))
        
        configCodeValidation
            .asDriver()
            .map {$0.message}
            .assign(to: \.configCodeValidationMessage, on: output)
            .store(in: cancelBag)
            
        Publishers
            .CombineLatest(nameValidation,surnameValidation)
            .map {$0.0.isValid && $0.1.isValid}
            .assign(to: \.isLoadEnabled1, on: output)
            .store(in: cancelBag)
        
        Publishers
            .CombineLatest(fathersnameValidation,phoneNumberValidation)
            .map {$0.0.isValid && $0.1.isValid}
            .assign(to: \.isLoadEnabled2, on: output)
            .store(in: cancelBag)
        
        Publishers
            .CombineLatest(ageValidation,cityValidation)
            .map {$0.0.isValid && $0.1.isValid}
            .assign(to: \.isLoadEnabled3, on: output)
            .store(in: cancelBag)
        
        let getCongfigsListInput = GetListInput(loadTrigger: input.getConfigsTrigger, reloadTrigger: Driver.empty(), getItems: useCase.getConfigs)
        
        let (configs, _, _, _) = getList(input: getCongfigsListInput).destructured
        
        configs
            .handleEvents(receiveOutput:{
              it in
                output.configs = it
            })
            .sink()
            .store(in: cancelBag)
        
        
        input.loadInputDataTrigger
            .delay(for: 0.1, scheduler: RunLoop.main)
            .sink(receiveValue: { resume in
                
            }) //temp
            .store(in: cancelBag)
//            .filter { _ in output.isLoadEnabled }
//            .map {_ in
//
//            }
//            .switchToLatest()
//            .sink()
//            .store(in: cancelBag)
        
        input.showBirthdayCalendarTrigger.sink { _ in
            withAnimation {
                output.bottomSheetPosition = .middle
            }
        }.store(in: cancelBag)
        
        input.chooseCityTrigger.sink{
            
            input.loadCitiesTrigger.sink().store(in: cancelBag)
            
            
            withAnimation {
                output.bottomSheetPosition = .middle
            }
            
        }.store(in: cancelBag)
        
        let getListInput = GetListInput(loadTrigger: input.loadCitiesTrigger.asDriver(), reloadTrigger: input.reloadCitiesTrigger.asDriver(), getItems: useCase.getCities)
        
        let (cities, _, _, _) = getList(input: getListInput).destructured
        
        cities
            .map{ $0.map { it in
                CityItemViewModel(city: it)
            }}
            .assign(to: \.cities, on: output)
            .store(in: cancelBag)
        
        
        return output
    }
}
