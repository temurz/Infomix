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
import ValidatedPropertyKit

public enum BottomSheetPositionBirthday: CGFloat, CaseIterable {
    case middle = 0.8, hidden = 0
}

struct OnlineApplicationViewModel{
    var useCase : OnlineApplicationUseCaseType
    var navigator : OnlineApplicationNavigatorType
    let buildUITrigger  = PassthroughSubject<Void,Never>()
    let showMarketChooserTrigger  = PassthroughSubject<Void,Never>()
    let loadMarketsTrigger = PassthroughSubject<Int, Never>()
    let loadCitiesTrigger = PassthroughSubject<Void,Never>()

}

extension OnlineApplicationViewModel : ViewModel{


    final class Input : ObservableObject{
        @Published var name = ""
        @Published var surname = ""
        @Published var fathersname = ""
        @Published var phoneNumber = ""
        @Published var configCode = ""
        @Published var aboutMe = ""
        @Published var shopNumber = ""
        let sendOnlineApplicationTrigger: Driver<Void>
        let chooseCityTrigger : Driver<Void>
        let startTrigger : Driver<Void>
        let toNextPageTrigger : Driver<Void>
        let showMarketChooserTrigger : Driver<Void>
        let popViewTrigger: Driver<Void>
        init(chooseCityTrigger: Driver<Void>, startTrigger: Driver<Void>,  sendOnlineApplicationTrigger: Driver<Void>, toNextPageTrigger: Driver<Void>, showMarketChooserTrigger: Driver<Void>, popViewTrigger: Driver<Void> ){
            self.chooseCityTrigger = chooseCityTrigger
            self.startTrigger = startTrigger
            self.sendOnlineApplicationTrigger = sendOnlineApplicationTrigger
            self.toNextPageTrigger = toNextPageTrigger
            self.showMarketChooserTrigger = showMarketChooserTrigger
            self.popViewTrigger = popViewTrigger
        }
    }

    final class Output : ObservableObject {
        @Published var isLoading = false
        @Published var alert = AlertMessage()
        @Published var birthday = Date()
        @Published var city = "City".localized()
        @Published var cityId = -1
        @Published var market = "Market".localized()
        @Published var marketId = -1
        @Published var bottomSheetPosition: BottomSheetPositionBirthday = .hidden
        @Published var cities = [CityItemViewModel]()
        @Published var markets = [MarketItemViewModel]()
        @Published var nameValidationMessage = ""
        @Published var surnameValidationMessage = ""
        @Published var fathersnameValidationMessage = ""
        @Published var phoneNumberValidationMessage = ""
        @Published var ageValidationMessage = ""
        @Published var cityValidationMessage = ""
        @Published var aboutMeValidationMessage = ""
        @Published var marketValidationMessage = ""
        @Published var shopNumberValidationMessage = ""
        @Published var photoIdCardValidationMessage = ""
        @Published var photoSelfieValidationMessage = ""
        @Published var loadEnabledArray = [String: Bool]()
        @Published var toastMessage = ""
        @Published var photoIdCard = Data()
        @Published var photoSelfie = Data()
        @Published var mapShow = [String : Bool]()
        @Published var requiredItemsList = [String]()
        @Published var nextPageExists = false
        @Published var showSecondPage = false
        @Published var imageChooserType: PickerImage.Source = .library
        @Published var isLoadingMarkets = false
        @Published var isShowingToast = false
    }

    func transform(_ input: Input, cancelBag: CancelBag) -> Output {

        let output = Output()
        let errorTracker = ErrorTracker()
        let activityTracker = ActivityTracker(false)

        self.buildUITrigger.asDriver().sink{

            for resume in CardConfig.shared.resumeFields! {
                if resume.isEnabledAndEqual("firstName"){
                    output.mapShow["firstName"] = true
                }
                if resume.isEnabledAndEqual("lastName"){
                    output.mapShow["lastName"] = true
                }
                if resume.isEnabledAndEqual("middleName"){
                    output.mapShow["middleName"] = true
                }
                if resume.isEnabledAndEqual("phone"){
                    output.mapShow["phone"] = true
                }
                if resume.isEnabledAndEqual("aboutMe"){
                    output.mapShow["aboutMe"] = true
                }
                if resume.isEnabledAndEqual("cityId") && !output.cities.isEmpty{
                    output.mapShow["cityId"] = true
                }
                if resume.isEnabledAndEqual("marketId") && !output.cities.isEmpty{
                    output.mapShow["marketId"] = true
                }
                if resume.isEnabledAndEqual("birthday"){
                    output.mapShow["birthday"] = true
                }
                if resume.isEnabledAndEqual("shopNumber") && !output.cities.isEmpty{
                    output.mapShow["shopNumber"] = true
                }
                if resume.isEnabledAndEqual("photoSelfie"){
                    output.mapShow["photoSelfie"] = true
                }
                if resume.isEnabledAndEqual("photoIdCard"){
                    output.mapShow["photoIdCard"] = true
                }

                if output.mapShow["photoIdCard"] ?? false || output.mapShow["photoSelfie"] ?? false {
                    output.nextPageExists = true
                }

            }
            output.$toastMessage.sink { message in
                if(message.isEmpty){
                    output.isShowingToast = false

                } else {
                    output.isShowingToast = true
                }

            }.store(in: cancelBag)

            output.requiredItemsList = (CardConfig.shared.resumeFields?.filter({ resumeField in
                resumeField.requiredField && resumeField.enabled
            }).map({ it in
                it.field
            }))!

            for i in output.requiredItemsList{
                output.loadEnabledArray[i] = false
            }


            if output.requiredItemsList.contains("firstName"){
                let nameValidation = Publishers
                    .CombineLatest(input.$name, input.toNextPageTrigger.merge(with: input.sendOnlineApplicationTrigger))
                    .map {$0.0}
                    .map(OnlineApplicationDto.validateName(_:))

                nameValidation
                    .asDriver()
                    .map{ $0.message}
                    .assign(to: \.nameValidationMessage, on: output)
                    .store(in: cancelBag)

                nameValidation
                    .map{$0.isValid}
                    .assign(to: \.loadEnabledArray["firstName"], on: output)
                    .store(in: cancelBag)
            }

            if output.requiredItemsList.contains("lastName"){
                let surnameValidation = Publishers
                    .CombineLatest(input.$surname, input.toNextPageTrigger.merge(with: input.sendOnlineApplicationTrigger))
                    .map {$0.0}
                    .map (OnlineApplicationDto.validateSurname(_:))

                surnameValidation
                    .asDriver()
                    .map { $0.message }
                    .assign(to: \.surnameValidationMessage, on: output)
                    .store(in: cancelBag)
                surnameValidation
                    .map{$0.isValid}
                    .assign(to: \.loadEnabledArray["lastName"], on: output)
                    .store(in: cancelBag)
                print(output.loadEnabledArray)
            }

            if output.requiredItemsList.contains("middleName"){
                let fathersnameValidation = Publishers
                    .CombineLatest(input.$fathersname, input.toNextPageTrigger.merge(with: input.sendOnlineApplicationTrigger))
                    .map {$0.0}
                    .map (OnlineApplicationDto.validateFathersname(_:))

                fathersnameValidation
                    .asDriver()
                    .map {$0.message}
                    .assign(to: \.fathersnameValidationMessage,on: output)
                    .store(in: cancelBag)
                fathersnameValidation
                    .map{$0.isValid}
                    .assign(to: \.loadEnabledArray["middleName"], on: output)
                    .store(in: cancelBag)
            }

            if output.requiredItemsList.contains("phone"){
                let phoneNumberValidation = Publishers
                    .CombineLatest(input.$phoneNumber, input.toNextPageTrigger.merge(with: input.sendOnlineApplicationTrigger))
                    .map {$0.0.getOnlyPhoneNumber()}
                    .map (OnlineApplicationDto.validatePhoneNumber(_:))

                phoneNumberValidation
                    .asDriver()
                    .map {$0.message}
                    .assign(to: \.phoneNumberValidationMessage, on: output)
                    .store(in: cancelBag)
                phoneNumberValidation
                    .map{$0.isValid}
                    .assign(to: \.loadEnabledArray["phone"], on: output)
                    .store(in: cancelBag)
            }

            if output.requiredItemsList.contains("birthday"){
                let ageValidation = Publishers
                    .CombineLatest(output.$birthday, input.toNextPageTrigger.merge(with: input.sendOnlineApplicationTrigger))
                    .map {$0.0}
                    .map (OnlineApplicationDto.validateAge(_:))

                ageValidation
                    .asDriver()
                    .map {$0.message}
                    .assign(to: \.ageValidationMessage, on: output)
                    .store(in: cancelBag)
                ageValidation
                    .map{$0.isValid}
                    .assign(to: \.loadEnabledArray["birthday"], on: output)
                    .store(in: cancelBag)
            }
            if output.requiredItemsList.contains("cityId") && !output.cities.isEmpty {
                let cityValidation = Publishers
                    .CombineLatest(output.$cityId, input.toNextPageTrigger.merge(with: input.sendOnlineApplicationTrigger))
                    .map {$0.0}
                    .map (OnlineApplicationDto.validateCity(_:))
                    .asDriver()

                cityValidation
                    .map { $0.message }
                    .assign(to: \.cityValidationMessage, on: output)
                    .store(in: cancelBag)

                cityValidation
                    .map { $0.isValid }
                    .assign(to: \.loadEnabledArray["cityId"], on: output)
                    .store(in: cancelBag)
            }

            if output.requiredItemsList.contains("marketId") && !output.cities.isEmpty {
                let marketValidation = Publishers
                    .CombineLatest(output.$marketId, input.toNextPageTrigger.merge(with: input.sendOnlineApplicationTrigger))
                    .map {$0.0}
                    .map (OnlineApplicationDto.validateMarket(_:))
                    .asDriver()

                marketValidation
                    .map { result in
                        if(output.markets.isEmpty && !output.isLoadingMarkets) {
                            return ""
                        } else {
                            return result.message
                        }}
                    .assign(to: \.marketValidationMessage, on: output)
                    .store(in: cancelBag)
                marketValidation
                    .map { validation in
                        if(output.markets.isEmpty && !output.isLoadingMarkets) {
                            return true
                        } else {
                            return validation.isValid
                        }}
                    .assign(to: \.loadEnabledArray["marketId"], on: output)
                    .store(in: cancelBag)
            }

            if output.requiredItemsList.contains("aboutMe"){
                let aboutMeValidation = Publishers
                    .CombineLatest(input.$aboutMe, input.toNextPageTrigger.merge(with: input.sendOnlineApplicationTrigger))
                    .map{$0.0}
                    .map(OnlineApplicationDto.validateAboutMe(_:))
                aboutMeValidation
                    .asDriver()
                    .map{$0.message}
                    .assign(to: \.aboutMeValidationMessage, on: output)
                    .store(in: cancelBag)
                aboutMeValidation
                    .map{$0.isValid}
                    .assign(to: \.loadEnabledArray["aboutMe"], on: output)
                    .store(in: cancelBag)
            }

            if output.requiredItemsList.contains("shopNumber") && !output.cities.isEmpty  {
                let shopNumberValidation = Publishers
                    .CombineLatest(input.$shopNumber, input.toNextPageTrigger.merge(with: input.sendOnlineApplicationTrigger))
                    .map{$0.0}
                    .map(OnlineApplicationDto.validateShopNumber(_:))
                shopNumberValidation
                    .asDriver()
                    .map{$0.message}
                    .assign(to: \.shopNumberValidationMessage, on: output)
                    .store(in: cancelBag)
                shopNumberValidation
                    .map{$0.isValid}
                    .assign(to: \.loadEnabledArray["shopNumber"], on: output)
                    .store(in: cancelBag)
            }


            if output.requiredItemsList.contains("photoIdCard"){
                let photoIdCardValidation = Publishers
                    .CombineLatest(output.$photoIdCard, input.sendOnlineApplicationTrigger.merge(with: input.toNextPageTrigger))
                    .map{$0.0}
                    .map(OnlineApplicationDto.validatePhotoIdCard(_:))
                photoIdCardValidation
                    .asDriver()
                    .map{$0.message}
                    .assign(to: \.photoIdCardValidationMessage ,on:output)
                    .store(in:cancelBag)
                photoIdCardValidation
                    .map{$0.isValid}
                    .assign(to: \.loadEnabledArray["photoIdCard"],on: output)
                    .store(in: cancelBag)
            }

            if output.requiredItemsList.contains("photoSelfie"){
                let photoSelfieValidation = Publishers
                    .CombineLatest(output.$photoSelfie, input.sendOnlineApplicationTrigger.merge(with: input.toNextPageTrigger))
                    .map{$0.0}
                    .map(OnlineApplicationDto.validatePhotoSelfie(_:))
                photoSelfieValidation
                    .asDriver()
                    .map{$0.message}
                    .assign(to: \.photoSelfieValidationMessage, on: output)
                    .store(in: cancelBag)
                photoSelfieValidation
                    .map{$0.isValid}
                    .assign(to: \.loadEnabledArray["photoSelfie"],on: output)
                    .store(in: cancelBag)
            }


        }.store(in: cancelBag)

        output.$cityId.sink { cityId in
            if(cityId>=0){
                self.loadMarketsTrigger.send(cityId)
            }
        }.store(in: cancelBag)

        input.showMarketChooserTrigger.sink { () in
            if(output.isLoadingMarkets){
                output.toastMessage = "Markets are loading. Please wait.".localized()
            } else if(!output.markets.isEmpty){
                withAnimation {
                    output.bottomSheetPosition = .middle
                }
            }
        }.store(in: cancelBag)

        let getMarketsListInput = GetListInput(loadTrigger: self.loadMarketsTrigger.asDriver(), reloadTrigger: Driver.empty(), getItems: useCase.getMarkets)

        let (markets, failedLoadMarkets, isLoadingMarkets, _) = getList(input: getMarketsListInput).destructured

        markets
            .map{ $0.map {it in
                MarketItemViewModel(market: it)
            }}
            .assign(to: \.markets, on: output)
            .store(in: cancelBag)

        failedLoadMarkets.sink { _ in
            output.markets = []
        }.store(in: cancelBag)

        isLoadingMarkets.assign(to: \.isLoadingMarkets, on: output)
            .store(in: cancelBag)

        output.$markets.sink { markets in
            if(markets.isEmpty && output.cityId > 0){
                output.market = "No markets found in this area.".localized()
            } else {
                output.market = "Market".localized()
            }
        }.store(in: cancelBag)

        input.toNextPageTrigger
            .delay(for: 0.1, scheduler: RunLoop.main)
            .filter{ _ in
                var enable = false
                for i in output.loadEnabledArray{
                    if i.value || i.key == "photoIdCard" || i.key == "photoSelfie"{
                        enable = true
                    }else{
                        enable = false
                        break
                    }
                }
                return enable
            }
            .map{_ in
                output.nextPageExists = false
                output.showSecondPage = true
            }
            .sink()
            .store(in: cancelBag)

        input.sendOnlineApplicationTrigger
            .delay(for: 0.1, scheduler: RunLoop.main)
            .filter { _ in
                var enable = false
                for i in output.loadEnabledArray{
                    if i.value{
                        enable = true
                    }else{
                        enable = false
                        break
                    }
                }
                return enable
            }
            .map { _ in
                self.useCase.sendOnlineApplication(
                    dto: OnlineApplicationDto(
                        username: input.name,
                        surname: input.surname,
                        fathersname: input.fathersname,
                        phoneNumber: input.phoneNumber.getOnlyPhoneNumber(),
                        age: output.birthday,
                        cityId: output.cityId,
                        configCode: CardConfig.shared.configCode,
                        aboutMe: input.aboutMe,
                        marketId: output.marketId,
                        shopNumber: input.shopNumber,
                        photoIdCard: output.photoIdCard,
                        photoSelfie: output.photoSelfie
                    )
                )
                    .trackError(errorTracker)
                    .trackActivity(activityTracker)
                    .asDriver()
            }
            .switchToLatest()
            .sink(receiveValue: { success in
                if success{
                    navigator.popView()
                }else{
                    output.toastMessage = "Cannot send your request!".localized()
                }
            }).store(in: cancelBag)

        input.chooseCityTrigger.sink{
            if(!output.cities.isEmpty){
                withAnimation {
                    output.bottomSheetPosition = .middle
                }
            }

        }.store(in: cancelBag)

        input.startTrigger.sink { () in
            if(CardConfig.shared.hasResumeField(fieldName: "cityId")){
                self.loadCitiesTrigger.send()
            }else{
                self.buildUITrigger.send()
            }
        }.store(in: cancelBag)

        let getListInput = GetListInput(loadTrigger: self.loadCitiesTrigger.asDriver(), reloadTrigger: Driver.empty(), getItems: useCase.getCities)

        let (cities, citiesLoadFailed, isLoading, _) = getList(input: getListInput).destructured

        cities
            .map{ $0.map { it in
                CityItemViewModel(city: it)
            }}
            .map{ result in
                self.buildUITrigger.send()
                return result
            }
            .assign(to: \.cities, on: output)
            .store(in: cancelBag)

        citiesLoadFailed
            .sink { _ in
                self.buildUITrigger.send()
            }.store(in: cancelBag)
        
        isLoading
            .assign(to: \.isLoading, on: output)
            .store(in: cancelBag)

        errorTracker
            .receive(on: RunLoop.main)
            .map { AlertMessage(error: $0) }
            .assign(to: \.alert, on: output)
            .store(in: cancelBag)

        activityTracker
            .receive(on: RunLoop.main)
            .assign(to: \.isLoading, on: output)
            .store(in: cancelBag)

        input.popViewTrigger
            .sink {
                navigator.popView()
            }
            .store(in: cancelBag)

        return output
    }
}
