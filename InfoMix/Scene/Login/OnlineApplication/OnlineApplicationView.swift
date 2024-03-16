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

struct OnlineApplicationView: View {
    
    @ObservedObject var input : OnlineApplicationViewModel.Input
    @ObservedObject var output : OnlineApplicationViewModel.Output
    private let cancelBag = CancelBag()
    
    
    let loadOnlineApplicationTrigger = PassthroughSubject<Void,Never>()
    let showBirthdayCalendarTrigger = PassthroughSubject<Void,Never>()
    let chooseCityTrigger = PassthroughSubject<Void,Never>()
    let loadCitiesTrigger = PassthroughSubject<Void,Never>()
    let reloadCitiesTrigger = PassthroughSubject<Void,Never>()
    let loadInputTrigger = PassthroughSubject<Void,Never>()
    let getCardConfigs = PassthroughSubject<Void,Never>()
    
    @State var focused: [Bool] = [true, false, false, false]
    @State var bottomContent = 0
    @State var cityIt = 0
    @State var dateId: UUID = UUID()
    @State var show = false
    
    var body: some View {
        ZStack{
            ScrollView{
                VStack(alignment: .leading, spacing: 24){
                    VStack(alignment: .leading){
                        if output.configs.count > 1{
                            Button{
                                show = true
                            }label:{
                                HStack{
                                    VStack(alignment: .leading){
                                        Text("Services".localized())
                                            .foregroundColor(Color.black)
                                            .font(.headline)
                                        
                                        Text(output.service.localized())
                                            .foregroundColor(Color.gray)
                                            .font(.subheadline)
                                    }
                                    Spacer()
                                    Image(systemName: "arrow.right")
                                    
                                }.padding(10)
                            }
                            .overlay(RoundedRectangle(cornerRadius: 16).stroke().foregroundColor(Color.gray))
                        }
                        Text(self.output.configCodeValidationMessage.localized())
                            .foregroundColor(.red)
                            .font(.footnote)
                            .lineLimit(nil)
                            .frame(maxHeight: .infinity)
                            .fixedSize()
                            .padding(.horizontal)
                    }
                    VStack(alignment: .leading){
                        TextFieldTyped1(keyboardType: .default, returnVal: .next, tag: 0, isSecure: false, text: $input.name, isfocusAble: $focused)
                            .placeholderText(when: input.name.isEmpty) {
                                Text("Name".localized())
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .background(lightGreyColor)
                            .frame(height: 36)
                            .cornerRadius(.greatestFiniteMagnitude)
                        
                        
                        Text(output.nameValidationMessage)
                            .foregroundColor(.red)
                            .font(.footnote)
                            .lineLimit(nil)
                            .frame(maxHeight: .infinity)
                            .fixedSize()
                            .padding(.horizontal)
                        
                    }.onTapGesture {
                        self.focused = [true, false, false, false]
                        withAnimation(.easeOut(duration: 0.2)) {
                            output.bottomSheetPosition = .hidden
                        }
                    }
                    VStack(alignment: .leading){
                        TextFieldTyped1(keyboardType: .default, returnVal: .next, tag: 1, isSecure: false, text: $input.surname, isfocusAble: $focused)
                            .placeholderText(when: input.surname.isEmpty) {
                                Text("Surname".localized())
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .background(lightGreyColor)
                            .frame(height: 36)
                            .cornerRadius(.greatestFiniteMagnitude)
                        
                        Text(output.surnameValidationMessage)
                            .foregroundColor(.red)
                            .font(.footnote)
                            .lineLimit(nil)
                            .frame(maxHeight: .infinity)
                            .fixedSize()
                            .padding(.horizontal)
                    }
                    .onTapGesture {
                        self.focused = [false, true, false, false]
                        withAnimation(.easeOut(duration: 0.2)) {
                            output.bottomSheetPosition = .hidden
                        }
                    }
                    VStack(alignment: .leading){
                        TextFieldTyped1(keyboardType: .default, returnVal: .next, tag: 2, isSecure: false, text: $input.fathersname, isfocusAble: $focused)
                            .placeholderText(when: input.fathersname.isEmpty) {
                                Text("Fathersname".localized())
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .background(lightGreyColor)
                            .frame(height: 36)
                            .cornerRadius(.greatestFiniteMagnitude)
                        
                        Text(output.fathersnameValidationMessage)
                            .foregroundColor(.red)
                            .font(.footnote)
                            .lineLimit(nil)
                            .frame(maxHeight: .infinity)
                            .fixedSize()
                            .padding(.horizontal)
                    }
                    .onTapGesture {
                        self.focused = [false, false, true, false]
                        withAnimation(.easeOut(duration: 0.2)) {
                            output.bottomSheetPosition = .hidden
                        }
                    }
                    VStack(alignment: .leading){
                        TextFieldTyped1(keyboardType: .namePhonePad, returnVal: .done, tag: 3, isSecure: false, text: $input.phoneNumber, isfocusAble: $focused)
                            .placeholderText(when: input.phoneNumber.isEmpty) {
                                Text("PhoneNumber".localized())
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .background(lightGreyColor)
                            .frame(height: 36)
                            .cornerRadius(.greatestFiniteMagnitude)
                        
                        Text(output.phoneNumberValidationMessage)
                            .foregroundColor(.red)
                            .font(.footnote)
                            .lineLimit(nil)
                            .frame(maxHeight: .infinity)
                            .fixedSize()
                            .padding(.horizontal)
                    }
                    .onTapGesture {
                        self.focused = [false, false, false, true]
                        withAnimation(.easeOut(duration: 0.2)) {
                            output.bottomSheetPosition = .hidden
                        }
                    }
                    VStack(alignment: .leading){
                        HStack{
                            Button {
                                //                showBirthdayCalendarTrigger.send()
                                //                bottomContent = 1
                                focused = [false,false,false,false]
                                withAnimation(.easeOut(duration: 0.2)) {
                                    output.bottomSheetPosition = .hidden
                                }
                            } label: {
                                HStack{
                                    DatePicker("Birthday".localized(), selection: $output.birthday, displayedComponents: .date)
                                        .environment(\.locale, Locale.init(identifier: Localize.currentLanguage()))
                                        .id(dateId)
                                    //                        .onChange(of: output.birthday, perform: { newValue in
                                    //                            dateId = UUID()
                                    //                        })
                                    
                                }
                                
                            }
                            .padding()
                            .background(lightGreyColor)
                            .frame(height: 36)
                            .cornerRadius(.greatestFiniteMagnitude)
                            
                            
                        }
                        Text(output.ageValidationMessage)
                            .foregroundColor(.red)
                            .font(.footnote)
                            .lineLimit(nil)
                            .frame(maxHeight: .infinity)
                            .fixedSize()
                            .padding(.horizontal)
                    }
                    VStack(alignment: .leading){
                        Button {
                            loadCitiesTrigger.send()
                            chooseCityTrigger.send()
                            bottomContent = 1
                            focused = [false, false, false, false]
                        } label: {
                            
                            HStack{
                                Text(output.city)
                                Spacer()
                            }
                        }
                        .padding()
                        .background(lightGreyColor)
                        .frame(height: 36)
                        .cornerRadius(.greatestFiniteMagnitude)
                        
                        Text(output.cityValidationMessage)
                            .foregroundColor(.red)
                            .font(.footnote)
                            .lineLimit(nil)
                            .frame(maxHeight: .infinity)
                            .fixedSize()
                            .padding(.horizontal)
                    }
                    
                    HStack{
                        Spacer()
                        Button {
                            loadInputTrigger.send()
                        } label: {
                            HStack{
                                Spacer()
                                Text("Load".localized())
                                    .foregroundColor(.white)
                                Spacer()
                            }
                            
                        }
                        .padding()
                        .background(Color.blue)
                        .frame(width: 200, height: 32)
                        .cornerRadius(.greatestFiniteMagnitude)
                        Spacer()
                    }
                    
                }.padding()
                
            }
            
            
            VStack{
                Color.white
                    .frame(width: UIScreen.main.bounds.width, height: 10)
                Spacer()
            }.onTapGesture {
                hideKeyboard()
            }
            
            .navigationTitle("Online application".localized())
            .bottomSheet(bottomSheetPosition: $output.bottomSheetPosition,options: [.swipeToDismiss, .tapToDissmiss, .noBottomPosition, .background(AnyView(Color.white)), .dragIndicatorColor(Color.red) , .backgroundBlur(effect: .light)]) {
                
                if bottomContent == 1{
                    CitiesView(cities: output.cities) { city, hasChosen, cityIteration in
                        output.city = city
                        
                        if hasChosen && cityIteration == -1{
                            output.isCityChosen = true
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
                                output.isCityChosen = true
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
                }
            }
            PopUpServices(configs: $output.configs, show: $show) { chosenConfig in
                output.chosenConfig = chosenConfig
                input.configCode = chosenConfig.configCode

                
                if UserDefaults.standard.object(forKey: "LCLCurrentLanguageKey") as? String == "ru"{
                    output.service = chosenConfig.titleRu ?? "service".localized()
                }else{
                    output.service = chosenConfig.titleUz ?? "service".localized()
                    
                }
            }
        }.ignoresSafeArea(.keyboard, edges: .bottom)
    }
    
    init(viewModel: OnlineApplicationViewModel){
        let input = OnlineApplicationViewModel.Input(showCalendar: showBirthdayCalendarTrigger.asDriver(), loadOnlineApplicationTrigger: loadOnlineApplicationTrigger.asDriver(), chooseCityTrigger: chooseCityTrigger.asDriver(),loadCitiesTrigger: loadCitiesTrigger.asDriver(),reloadCitiesTrigger: reloadCitiesTrigger.asDriver(), loadInputTrigger: loadInputTrigger.asDriver(), getConfigsTrigger: getCardConfigs.asDriver())
        
        output = viewModel.transform(input, cancelBag: cancelBag)
        self.input = input
        loadCitiesTrigger.send()
        self.getCardConfigs.send()
    }
}

struct OnlineApplicationView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel:OnlineApplicationViewModel = PreviewAssembler().resolve(navigationController: UINavigationController())
        OnlineApplicationView(viewModel: viewModel)
    }
}


struct TextFieldTyped1: UIViewRepresentable {
    let keyboardType: UIKeyboardType
    let returnVal: UIReturnKeyType
    let tag: Int
    let isSecure: Bool
    @Binding var text: String
    @Binding var isfocusAble: [Bool]
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.keyboardType = self.keyboardType
        textField.returnKeyType = self.returnVal
        textField.tag = self.tag
        textField.delegate = context.coordinator
        textField.autocorrectionType = .no
        textField.isSecureTextEntry = isSecure
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        if !isfocusAble[tag]{
            uiView.resignFirstResponder()
            return
        }
        
        if !uiView.isFirstResponder {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                uiView.becomeFirstResponder()
            }
        }
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: TextFieldTyped1
        
        init(_ textField: TextFieldTyped1) {
            self.parent = textField
        }
        
        
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            // Without async this will modify the state during view update.
            DispatchQueue.main.async {
                self.parent.text = textField.text ?? ""
            }
        }
        
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            var focus = self.parent.isfocusAble
            
            if parent.tag == 0 {
                
                focus = [false, true, false, false]
            } else if parent.tag == 1 {
                focus = [false, false,true, false]
            }else if parent.tag == 2{
                focus = [false,false, false, true]
            }else if parent.tag == 3{
                focus = [false, false, false, false]
            }
            DispatchQueue.main.async {
                self.parent.isfocusAble = focus
            }
            return true
        }
    }
}
