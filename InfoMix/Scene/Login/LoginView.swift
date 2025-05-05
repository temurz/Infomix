//
//  LoginView.swift
//  CleanArchitecture
//
//  Created by Tuan Truong on 7/29/20.
//  Copyright © 2020 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine

let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)

struct LoginView: View {
    @ObservedObject var input: LoginViewModel.Input
    @ObservedObject var output: LoginViewModel.Output
    @State private var focused: [Bool] = [true, false]
    @State private var show = false
    @State private var showOnlineApplicationText = false

    private let cancelBag = CancelBag()
    private let loginTrigger = PassthroughSubject<Void, Never>()
    private let languageTrigger = PassthroughSubject<String,Never>()
    private let onlineApplicationTrigger = PassthroughSubject<Void,Never>()
    private let getConfigsTrigger = PassthroughSubject<Void,Never>()

    var body: some View {


        return LoadingView(isShowing: $output.isLoading, text: .constant("")) {
            ZStack{
                VStack(alignment: .center, spacing: 0) {
                    WelcomeView()
                    VStack{
                        if output.configs.count > 1 {
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
                            HStack{
                            Text(self.output.configCodeValidationMessage.localized())
                                .foregroundColor(.red)
                                .font(.footnote)
                                .lineLimit(nil)
                                .frame(maxHeight: .infinity)
                                .fixedSize()
                                Spacer()
                            }
                        }else if output.configs.count == 0 {
                            Text("Server temporarily is not available".localized())
                                .foregroundColor(.red)
                                .font(.footnote)
                                .lineLimit(nil)
                                .frame(maxHeight: .infinity)
                                .fixedSize()
                        }else {
                            Text("")
                                .onAppear{
                                    var newConfig = output.configs[0]
                                    newConfig.normalizeSteps()
                                    output.chosenConfig = newConfig
                                    CardConfig.shared = newConfig
                                    if output.chosenConfig.resumeFields != nil || !output.chosenConfig.resumeFields!.isEmpty{
                                        showOnlineApplicationText = true
                                        print(output.chosenConfig.resumeFields?.count)
                                    }

                                }
                        }

                    }.padding(.bottom,15)

                    VStack(alignment: .leading){

                        HStack {
                            TextField("Certificate".localized(), text: $input.username)
                                .padding()
                        }
                        .background(lightGreyColor)
                        .frame(height: 50)
                        .cornerRadius(5.0)
//                        TextFieldTyped(keyboardType: .default, returnVal: .done, tag: 0,   isSecure: false, text: $input.username, isfocusAble: $focused)
//                            .placeholderText(when: input.username.isEmpty, placeholder: {
//                                Text("Certificate".localized())
//                                    .foregroundColor(.gray)
//                            })
//                            .padding(10)
//                            .background(lightGreyColor)
//                            .frame(height: 50)
//                            .cornerRadius(5.0).onTapGesture {
//                                self.focused = [true, false]
//                            }


                        Text(self.output.usernameValidationMessage.localized())
                            .foregroundColor(.red)
                            .font(.footnote)
                            .lineLimit(nil)
                            .frame(maxHeight: .infinity)
                            .fixedSize()
                    }.padding(.bottom,10)
                    VStack(alignment: .leading){
                        HStack {
                            SecureField("Password".localized(), text: $input.password)
                                .padding()
                        }
                        .background(lightGreyColor)
                        .frame(height: 50)
                        .cornerRadius(5.0)

//                        TextFieldTyped(keyboardType: .default, returnVal: .done, tag: 1, isSecure: true, text: $input.password, isfocusAble: $focused)
//                            .placeholderText(when: input.password.isEmpty, placeholder: {
//                                Text("Password".localized())
//                                    .foregroundColor(Color.gray)
//                            })
//                            .padding(10)
//                            .background(lightGreyColor)
//                            .frame(height: 50)
//                            .cornerRadius(5.0)
//                            .onTapGesture {
//                                self.focused = [false, true]
//                            }
                        Text(self.output.passwordValidationMessage.localized())
                            .foregroundColor(.red)
                            .font(.footnote)
                            .lineLimit(nil)
                            .frame(maxHeight: .infinity)
                            .fixedSize()
                    }.padding(.bottom,10)
                    HStack{
                        Spacer()
                        Button(action: {self.loginTrigger.send(())}) {
                            Text("Login".localized())
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 200, height: 40)
                                .background(Color.green)
                                .cornerRadius(15.0)

                        } .disabled(!self.output.isLoginEnabled)
                        Spacer()
                    }
                    VStack(spacing: 2){

                        if output.configs.count != 0 && showOnlineApplicationText{
                            Text("You don't have certificate?\nDo you want to get one of the mentioned services?".localized())
                                .foregroundColor(.gray)

                                .font(.system(size:14))
                                .lineLimit(nil)
                                .multilineTextAlignment(.center)
                                .frame(width: 260, height: 80, alignment: .center)
                                .fixedSize()
                            Button {
                                onlineApplicationTrigger.send()
                            } label: {
                                Text("Leave an online application".localized())
                            }
                        }else{
                            Spacer()
                                .frame(width: 24, height: 24)
                        }


                        HStack{
                            Text("Ru")
                                .padding(.horizontal)
                                .font(.system(size: 18))
                                .onTapGesture {
                                    self.languageTrigger.send("ru")
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                        input.change = "123"
                                    }
                                }

                            Text("Uz")
                                .padding(.horizontal)
                                .font(.system(size: 18))
                                .onTapGesture {
                                    self.languageTrigger.send("uz")
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                        input.change = "123"
                                    }
                                }

                        }
                    }
                    Spacer()

                }
                .padding()
                PopUpServices(configs: $output.configs, show: $show) { chosenConfig in
                    var newConfig = chosenConfig
                    newConfig.normalizeSteps()
                    output.chosenConfig = newConfig
                    input.configCode = newConfig.configCode
                    CardConfig.shared = newConfig
                    if newConfig.resumeFields != nil && !newConfig.resumeFields!.isEmpty {
                        showOnlineApplicationText = true
                        print(output.chosenConfig.resumeFields?.count)
                        print(output.chosenConfig.resumeFields)
                    }

                    UserDefaults.standard.set(newConfig.configCode, forKey: "configCode")
                    UserDefaults.standard.set(newConfig.configVersion, forKey: "configVersion")

                    if newConfig.titleTranslations?.count ?? 0 < 1 {
                        output.service = "service".localized()
                    }
                    switch UserDefaults.standard.object(forKey: "LCLCurrentLanguageKey") as? String {
                    case "ru":
                        let _ = newConfig.titleTranslations?.forEach { translation in
                            if translation.locale == "ru" {
                                output.service = translation.value ?? "service".localized()
                            }
                        }
                    case "uz":
                        let _ = newConfig.titleTranslations?.forEach { translation in
                            if translation.locale == "uz" {
                                output.service = translation.value ?? "service".localized()
                            }
                        }
                    default:
                        let _ = newConfig.titleTranslations?.forEach { translation in
                            if translation.locale == "en" {
                                output.service = translation.value ?? "service".localized()
                            }
                        }
                    }

                }
            }
            .alert(isPresented: $output.alert.isShowing) {
                Alert(
                    title: Text(output.alert.title),
                    message: Text(output.alert.message),
                    dismissButton: .default(Text("OK"))
                )
            }

        }

    }

    init(viewModel: LoginViewModel) {
        let input = LoginViewModel.Input(loginTrigger: loginTrigger.asDriver(), languageTrigger: languageTrigger.asDriver(), onlineApplicationTrigger: onlineApplicationTrigger.asDriver(), getConfigstrigger: getConfigsTrigger.asDriver())
        output = viewModel.transform(input, cancelBag: cancelBag)
        self.input = input
        self.getConfigsTrigger.send()
    }
}
struct WelcomeView : View {
    var body: some View {
        return Image("logo")
            .resizable()
            .scaledToFit()
            .frame(width: 240, height: 160)
            .padding(.horizontal)
            .padding(.bottom)

    }
}



struct TextFieldTyped: UIViewRepresentable {
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
        var parent: TextFieldTyped

        init(_ textField: TextFieldTyped) {
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

                focus = [false, true]
            } else if parent.tag == 1 {
                focus = [false, false]
            }
            DispatchQueue.main.async {
                self.parent.isfocusAble = focus
            }
            return true
        }
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel: LoginViewModel = PreviewAssembler().resolve(navigationController: UINavigationController(),  cardConfig: CardConfig(configCode: "AAOo2"))
        return LoginView(viewModel: viewModel)
    }
}

extension View {
    func placeholderText<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
}
