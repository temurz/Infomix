//
//  OnlineApplicationView.swift
//  InfoMix
//
//  Created by Temur on 07/03/22.
//  Copyright © 2022 InfoMix. All rights reserved.
//

import SwiftUI
import Combine
import Localize_Swift
import AlertToast

struct OnlineApplicationView: View {
    
    @ObservedObject var input : OnlineApplicationViewModel.Input
    @ObservedObject var output : OnlineApplicationViewModel.Output
    private let cancelBag = CancelBag()
    
    let loadOnlineApplicationTrigger = PassthroughSubject<Void,Never>()
    let chooseCityTrigger = PassthroughSubject<Void,Never>()
    let startTrigger = PassthroughSubject<Void,Never>()
    let reloadCitiesTrigger = PassthroughSubject<Void,Never>()
    let sendOnlineApplicationTrigger = PassthroughSubject<Void,Never>()
    let toNextPageTrigger = PassthroughSubject<Void,Never>()
    let showMarketChooserTrigger = PassthroughSubject<Void,Never>()
    let popViewTrigger = PassthroughSubject<Void,Never>()
    @State var bottomContent = 0
    @State var cityIt = 0
    @State var dateId: UUID = UUID()
    @State var showDatePicker = false
    @State private var showToast = false
    private var resumeFields = CardConfig.shared.resumeFields
    var body: some View {
        return LoadingView(isShowing: $output.isLoading, text: .constant("")) {
            VStack {
                CustomNavigationBar(title: "Online application".localized()) {
                    popViewTrigger.send(())
                }
                ScrollView {
                    VStack(alignment: .leading, spacing: 14){
                        if !output.showSecondPage {
                            VStack(spacing: 12) {
                                if output.mapShow["firstName"] ?? false {
                                    TextFieldWithValidation(inputText: $input.name, placeholder: "Name".localized(), validationMessage: output.nameValidationMessage)
                                }
                                if output.mapShow["lastName"] ?? false{
                                    TextFieldWithValidation(inputText: $input.surname, placeholder: "Surname".localized(), validationMessage: output.surnameValidationMessage)
                                }
                                if output.mapShow["middleName"] ?? false{
                                    TextFieldWithValidation(inputText: $input.fathersname, placeholder: "Fathersname".localized(), validationMessage: output.fathersnameValidationMessage)
                                }
                                if output.mapShow["phone"] ?? false {
                                    VStack(alignment: .leading) {
                                        MaskedTextField(mask: "+XXX(XX) XXX-XX-XX", placeholder: "+998 (__) ___-__-__", text: $input.phoneNumber)
                                            .padding()
                                            .frame(height: 44)
                                            .background(lightGreyColor)
                                            .cornerRadius(12)
                                        Text(output.phoneNumberValidationMessage)
                                            .foregroundColor(.red)
                                            .font(.footnote)
                                            .lineLimit(nil)
                                    }
                                    
//                                    TextFieldWithValidation(inputText: $input.phoneNumber, placeholder: "PhoneNumber".localized(), validationMessage: output.phoneNumberValidationMessage, keyboardType: .numbersAndPunctuation)
                                }
                                if output.mapShow["aboutMe"] ?? false {
                                    TextFieldWithValidation(inputText: $input.aboutMe, placeholder: "About yourself".localized(), validationMessage: output.aboutMeValidationMessage)
                                }
                                VStack(alignment: .leading) {
                                    if  (output.mapShow["birthday"] ?? false) {
                                        DatePicker("Birthday".localized(), selection: $output.birthday, displayedComponents: .date)
                                            .padding()
                                            .frame(height: 44)
                                            .background(lightGreyColor)
                                            .cornerRadius(12)
                                    }
                                    Text(output.ageValidationMessage)
                                        .foregroundColor(.red)
                                        .font(.footnote)
                                        .lineLimit(nil)
                                }
                                VStack(alignment: .leading) {
                                    if output.mapShow["cityId"] ?? false{
                                        Button {
                                            chooseCityTrigger.send()
                                            bottomContent = 1
                                        } label: {
                                            
                                            HStack{
                                                Text(output.city)
                                                Spacer()
                                            }
                                        }
                                        .padding()
                                        .background(lightGreyColor)
                                        .frame(height: 44)
                                        .cornerRadius(12)
                                    }
                                    Text(output.cityValidationMessage)
                                        .foregroundColor(.red)
                                        .font(.footnote)
                                        .lineLimit(nil)
                                }
                                VStack(alignment: .leading) {
                                    if output.mapShow["marketId"] ?? false{
                                        Button {
                                            showMarketChooserTrigger.send()
                                            bottomContent = 3
                                        } label: {
                                            HStack{
                                                Text(output.market)
                                                Spacer()
                                                if(output.isLoadingMarkets){
                                                    ProgressView()
                                                        .progressViewStyle(.circular)
                                                }
                                            }
                                        }
                                        .padding()
                                        .background(lightGreyColor)
                                        .frame(height: 44)
                                        .cornerRadius(12)
                                    }
                                    Text(output.marketValidationMessage)
                                        .foregroundColor(.red)
                                        .font(.footnote)
                                        .lineLimit(nil)
                                }
                                if output.mapShow["shopNumber"] ?? false {
                                    TextFieldWithValidation(inputText: $input.shopNumber, placeholder: "Shop Number".localized(), validationMessage: output.shopNumberValidationMessage)
                                }
                            }
                        }
                        if output.showSecondPage {
                            VStack {
                                OnlineApplicationImageView(output: output, title: "Make a photo of ID".localized(), selectedImage: $output.photoIdCard)
                                    .onAppear {
                                        UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
                                    }
                                Text(output.photoIdCardValidationMessage)
                                    .foregroundColor(.red)
                                    .font(.footnote)
                                    .lineLimit(nil)
                                    .frame(maxHeight: .infinity)
                                    .fixedSize()
                                    .padding(.horizontal)
                                OnlineApplicationImageView(output: output, title: "Make a selfie".localized(), selectedImage: $output.photoSelfie)
                                    .onAppear {
                                        UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
                                    }
                                Text(output.photoSelfieValidationMessage)
                                    .foregroundColor(.red)
                                    .font(.footnote)
                                    .lineLimit(nil)
                                    .frame(maxHeight: .infinity)
                                    .fixedSize()
                                    .padding(.horizontal)
                            }
                        }
                        Button {
                            if output.nextPageExists{
                                toNextPageTrigger.send()
                            }else{
                                sendOnlineApplicationTrigger.send()
                            }
                        } label: {
                            Text(output.nextPageExists ? "Next".localized() : "Load".localized())
                                .foregroundColor(.white)
                                .bold()
                                .frame(maxWidth: .infinity)
                        }
                        .padding()
                        .background(Colors.appMainColor)
                        .frame(height: 44)
                        .cornerRadius(.greatestFiniteMagnitude)
                        .toast(isPresenting: $output.isShowingToast) {
                            AlertToast(displayMode: .banner(.slide) ,type: .regular, title: output.toastMessage)
                        }
                        if output.showSecondPage {
                            HStack {
                                Spacer()
                                Button {
                                    output.showSecondPage = false
                                    output.nextPageExists = true
                                } label: {
                                    Text("Go back".localized())
                                }
                                Spacer()
                            }
                        }
                        
                    }
                    .padding()
                    .ignoresSafeArea(.keyboard)
                }
            }
            .bottomSheet(bottomSheetPosition: $output.bottomSheetPosition,options: [.swipeToDismiss, .tapToDissmiss, .noBottomPosition, .background(AnyView(Color.white)), .dragIndicatorColor(Color.red) , .backgroundBlur(effect: .light)]) {
                
                if bottomContent == 1{
                    CitiesView(cities: output.cities) { city, hasChosen, cityIteration,cityId  in
                        output.city = city
                        output.cityId = cityId
                        
                        if hasChosen && cityIteration == -1{
                            output.cityId = cityId
                            withAnimation(.easeOut(duration: 0.2)) {
                                output.bottomSheetPosition = .hidden
                            }
                        }else{
                            bottomContent = 2
                            cityIt = cityIteration
                        }
                    }
                }else if bottomContent == 2{
                    VStack{
                        ForEach(output.cities[cityIt].child!){city in
                            Button{
                                output.city = city.name ?? ""
                                output.cityId = city.id
                                withAnimation(.easeOut(duration: 0.2)) {
                                    output.bottomSheetPosition = .hidden
                                }
                            }label: {
                                VStack{
                                    Text(city.name ?? "")
                                    Divider()
                                }
                            }
                        }
                        Spacer()
                    }
                }else if bottomContent == 3 {
                    MarketView(markets: output.markets) { marketName, marketId, hasChosen in
                        output.market = marketName
                        output.marketId = marketId
                        
                        if hasChosen{
                            withAnimation(.easeOut(duration: 0.2)){
                                output.bottomSheetPosition = .hidden
                            }
                        }
                    }
                }
                
            }
        }

        
    }
    
    init(viewModel: OnlineApplicationViewModel){
        let input = OnlineApplicationViewModel.Input( chooseCityTrigger: chooseCityTrigger.asDriver(),startTrigger: startTrigger.asDriver(), sendOnlineApplicationTrigger: sendOnlineApplicationTrigger.asDriver(), toNextPageTrigger: toNextPageTrigger.asDriver(),  showMarketChooserTrigger: showMarketChooserTrigger.asDriver(), popViewTrigger:popViewTrigger.asDriver())
        
        output = viewModel.transform(input, cancelBag: cancelBag)
        self.input = input
        self.startTrigger.send()
        
    }
}

struct OnlineApplicationView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel:OnlineApplicationViewModel = PreviewAssembler().resolve(navigationController: UINavigationController())
        OnlineApplicationView(viewModel: viewModel)
    }
}
