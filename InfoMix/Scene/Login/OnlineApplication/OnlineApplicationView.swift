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
    @State var focused: [Bool] = [true, false, false, false, false, false]
    @State var bottomContent = 0
    @State var cityIt = 0
    @State var dateId: UUID = UUID()
    @State var showDatePicker = false
    @State private var showToast = false
    private var resumeFields = CardConfig.shared.resumeFields
    var body: some View {
        VStack {
            CustomNavigationBar(title: "Online application".localized()) {
                popViewTrigger.send(())
            }
            ZStack{
                ScrollView{
                    VStack(alignment: .leading, spacing: 14){
                        if !output.showSecondPage{
                    Group{
                            VStack(alignment: .leading){
                                if output.mapShow["firstName"] ?? false{
                                    TextFieldTyped1(keyboardType: .default, returnVal: .done, tag: 0, isSecure: false, text: $input.name, isfocusAble: $focused)
                                        .placeholderText(when: input.name.isEmpty) {
                                            Text("Name".localized())
                                                .foregroundColor(.gray)
                                        }
                                        .placeholderText(when: !input.name.isEmpty, placeholder: {
                                            Text(input.name)
                                        })
                                        .padding()
                                        .background(lightGreyColor)
                                        .frame(height: 36)
                                        .cornerRadius(.greatestFiniteMagnitude)
                                        .ignoresSafeArea(.keyboard, edges: .bottom)
                                        Text(output.nameValidationMessage)
                                            .foregroundColor(.red)
                                            .font(.footnote)
                                            .lineLimit(nil)
                                            .frame(maxHeight: .infinity)
                                            .fixedSize()
                                            .padding(.horizontal)

                                }

                            }.onTapGesture {
                                self.focused = [true, false, false, false,false, false]
                                withAnimation(.easeOut(duration: 0.2)) {
                                    output.bottomSheetPosition = .hidden
                                }
                            }

                            VStack(alignment: .leading){

                                if output.mapShow["lastName"] ?? false{
                                    TextFieldTyped1(keyboardType: .default, returnVal: .done, tag: 1, isSecure: false, text: $input.surname, isfocusAble: $focused)
                                        .placeholderText(when: input.surname.isEmpty){
                                            Text("Surname".localized())
                                                .foregroundColor(.gray)
                                        }
                                        .placeholderText(when: !input.surname.isEmpty, placeholder: {
                                            Text(input.surname)
                                        })
                                        .padding()
                                        .background(lightGreyColor)
                                        .frame(height: 36)
                                        .cornerRadius(.greatestFiniteMagnitude)
                                }

                                    Text(output.surnameValidationMessage)
                                        .foregroundColor(.red)
                                        .font(.footnote)
                                        .lineLimit(nil)
                                        .frame(maxHeight: .infinity)
                                        .fixedSize()
                                        .padding(.horizontal)


                            }
                            .onTapGesture {
                                self.focused = [false, true, false, false,false, false]
                                withAnimation(.easeOut(duration: 0.2)) {
                                    output.bottomSheetPosition = .hidden
                                }
                            }


                            VStack(alignment: .leading){

                                if output.mapShow["middleName"] ?? false{
                                    TextFieldTyped1(keyboardType: .default, returnVal: .done, tag: 2, isSecure: false, text: $input.fathersname, isfocusAble: $focused)
                                        .placeholderText(when: input.fathersname.isEmpty) {
                                            Text("Fathersname".localized())
                                                .foregroundColor(.gray)
                                        }
                                        .placeholderText(when: !input.fathersname.isEmpty, placeholder: {
                                            Text(input.fathersname)
                                        })
                                        .padding()
                                        .background(lightGreyColor)
                                        .frame(height: 36)
                                        .cornerRadius(.greatestFiniteMagnitude)
                                }
                                    Text(output.fathersnameValidationMessage)
                                        .foregroundColor(.red)
                                        .font(.footnote)
                                        .lineLimit(nil)
                                        .frame(maxHeight: .infinity)
                                        .fixedSize()
                                        .padding(.horizontal)
                            }
                            .onTapGesture {
                                self.focused = [false, false, true, false,false, false]
                                withAnimation(.easeOut(duration: 0.2)) {
                                    output.bottomSheetPosition = .hidden
                                }
                            }

                        VStack(alignment: .leading){

                            if output.mapShow["phone"] ?? false{
                                    TextFieldTyped1(keyboardType: .namePhonePad, returnVal: .done, tag: 3, isSecure: false, text: $input.phoneNumber, isfocusAble: $focused)
                                        .placeholderText(when: input.phoneNumber.isEmpty) {
                                            Text("PhoneNumber".localized())
                                                .foregroundColor(.gray)
                                        }
                                        .placeholderText(when: !input.phoneNumber.isEmpty, placeholder: {
                                            Text(input.phoneNumber)
                                        })
                                        .padding()
                                        .background(lightGreyColor)
                                        .frame(height: 36)
                                        .cornerRadius(.greatestFiniteMagnitude)
                                }

                                    Text(output.phoneNumberValidationMessage)
                                        .foregroundColor(.red)
                                        .font(.footnote)
                                        .lineLimit(nil)
                                        .frame(maxHeight: .infinity)
                                        .fixedSize()
                                        .padding(.horizontal)

                        }
                        .onTapGesture {
                            self.focused = [false, false, false, true,false, false]
                            withAnimation(.easeOut(duration: 0.2)) {
                                output.bottomSheetPosition = .hidden
                            }
                        }
                        VStack(alignment: .leading){

                            if output.mapShow["aboutMe"] ?? false{
                                    TextFieldTyped1(keyboardType: .default, returnVal: .done, tag: 4, isSecure: false, text: $input.aboutMe, isfocusAble: $focused)
                                        .placeholderText(when: input.aboutMe.isEmpty) {
                                            Text("About yourself".localized())
                                                .foregroundColor(.gray)
                                        }
                                        .placeholderText(when: !input.aboutMe.isEmpty, placeholder: {
                                            Text(input.aboutMe)
                                        })
                                        .padding()
                                        .background(lightGreyColor)
                                        .frame(height: 36)
                                        .cornerRadius(.greatestFiniteMagnitude)

                                }

                                    Text(output.aboutMeValidationMessage)
                                        .foregroundColor(.red)
                                        .font(.footnote)
                                        .lineLimit(nil)
                                        .frame(maxHeight: .infinity)
                                        .fixedSize()
                                        .padding(.horizontal)

                        }
                        .onTapGesture {
                            self.focused = [false, false, false, false, true, false]
                        }


                        VStack(alignment: .leading){
                            if  (output.mapShow["birthday"] ?? false) {
                                DatePicker("Birthday".localized(), selection: $output.birthday, displayedComponents: .date)
                                    .padding()
                                    .frame(height: 36)
                                    .background(lightGreyColor)
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

                            if output.mapShow["cityId"] ?? false{
                                    Button {
                                        chooseCityTrigger.send()
                                        bottomContent = 1
                                        focused = [false, false, false, false,false, false]
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
                                }

                                    Text(output.cityValidationMessage)
                                        .foregroundColor(.red)
                                        .font(.footnote)
                                        .lineLimit(nil)
                                        .frame(maxHeight: .infinity)
                                        .fixedSize()
                                        .padding(.horizontal)


                        }
                            VStack{
                                if output.mapShow["marketId"] ?? false{
                                        Button {
                                            showMarketChooserTrigger.send()
                                            focused = [false, false, false, false,false, false]
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
                                        .frame(height: 36)
                                        .cornerRadius(.greatestFiniteMagnitude)
                                    }
                                        Text(output.marketValidationMessage)
                                            .foregroundColor(.red)
                                            .font(.footnote)
                                            .lineLimit(nil)
                                            .frame(maxHeight: .infinity)
                                            .fixedSize()
                                            .padding(.horizontal)

                            }
                        VStack(alignment: .leading){
                                if output.mapShow["shopNumber"] ?? false{
                                        TextFieldTyped1(keyboardType: .default, returnVal: .done, tag: 5, isSecure: false, text: $input.shopNumber, isfocusAble: $focused)
                                            .placeholderText(when: input.shopNumber.isEmpty) {
                                                Text("Shop Number".localized())
                                                    .foregroundColor(.gray)
                                            }
                                            .placeholderText(when: !input.shopNumber.isEmpty, placeholder: {
                                                Text(input.shopNumber)
                                            })
                                            .padding()
                                            .background(lightGreyColor)
                                            .frame(height: 36)
                                            .cornerRadius(.greatestFiniteMagnitude)
                                    }

                                        Text(output.shopNumberValidationMessage)
                                            .foregroundColor(.red)
                                            .font(.footnote)
                                            .lineLimit(nil)
                                            .frame(maxHeight: .infinity)
                                            .fixedSize()
                                            .padding(.horizontal)
                            }.onTapGesture {
                                focused = [false, false,false,false,false,true]
                            }
                    }
                        }

                        if output.showSecondPage{
                            VStack{
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
                        HStack{
                            Spacer()
                            Button {
                                if output.nextPageExists{
                                    toNextPageTrigger.send()
                                }else{
                                    sendOnlineApplicationTrigger.send()
                                }


                            } label: {
                                HStack{
                                    Spacer()
                                    if output.nextPageExists{
                                        Text("Next".localized())
                                            .foregroundColor(.white)
                                    }else{
                                        Text("Load".localized())
                                            .foregroundColor(.white)
                                    }
                                    Spacer()
                                }

                            }
                            .padding()
                            .background(Color.blue)
                            .frame(width: 200, height: 32)
                            .cornerRadius(.greatestFiniteMagnitude)

                            Spacer()
                        }
                        .toast(isPresenting: $output.isShowingToast) {
                            AlertToast(displayMode: .banner(.slide) ,type: .regular, title: output.toastMessage)
                        }

                        if output.showSecondPage{
                            HStack{
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

                    }.padding()
                        .ignoresSafeArea(.keyboard)
                }

                VStack{
                    Color.white
                        .frame(width: UIScreen.main.bounds.width, height: 10)
                    Spacer()
                }.onTapGesture {
                    hideKeyboard()
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
                    }else if bottomContent == 3{
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

            if parent.returnVal == .done{
                focus = [false,false, false, false, false, false]
            }
//            if parent.tag == 0 {
//
//                focus = [false, true, false, false,false]
//            } else if parent.tag == 1 {
//                focus = [false, false,true, false,false]
//            }else if parent.tag == 2{
//                focus = [false,false, false, true,false]
//            }else if parent.tag == 3{
//                if parent.returnVal == .done{
//                    focus = [false, false, false, false,false]
//                }else{
//                    focus = [false, false, false, false,true]
//                }
//
//            }else if parent.tag == 4 {
//                focus = [false,false,false,false,false]
//            }
            DispatchQueue.main.async {
                self.parent.isfocusAble = focus
            }
            return true
        }
    }
}


