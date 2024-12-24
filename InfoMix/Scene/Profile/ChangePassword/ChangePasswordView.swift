//
//  ChangePasswordView.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 17/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine

struct ChangePasswordView: View {
    
    @ObservedObject var input: ChangePasswordViewModel.Input
    @ObservedObject var output: ChangePasswordViewModel.Output
    let cancelBag = CancelBag()
    
    let changePasswordTrigger = PassthroughSubject<Void, Never>()
    let popViewTrigger = PassthroughSubject<Void, Never>()
    var body: some View {
        LoadingView(isShowing: $output.isChangingPassword, text: .constant("")) {
            VStack {
                CustomNavigationBar(title: "Change password".localized()) {
                    popViewTrigger.send(())
                }
                VStack(alignment: .leading){
                    SecureField("Password".localized(), text: self.$input.password)
                                 .padding()
                                 .background(lightGreyColor)
                                 .cornerRadius(5.0)
                    Text(self.output.passwordValidationMessage)
                        .foregroundColor(.red)
                        .font(.footnote)
                        .lineLimit(nil)
                        .frame(maxHeight: .infinity)
                        .fixedSize()
                }
                .padding()
                VStack(alignment: .leading){
                    SecureField("New password".localized(), text: self.$input.newPassword)
                                 .padding()
                                 .background(lightGreyColor)
                                 .cornerRadius(5.0)
                    Text(self.output.newPasswordValidationMessage)
                        .foregroundColor(.red)
                        .font(.footnote)
                        .lineLimit(nil)
                        .frame(maxHeight: .infinity)
                        .fixedSize()
                }
                .padding(.bottom,15)
                .padding(.horizontal)
                HStack{
                    Spacer()
                    Button(action: {self.changePasswordTrigger.send(())}) {
                        ChangePasswordButtonContent()
                               } .disabled(!self.output.isChangeEnabled)
                    Spacer()
                }
                Spacer()
                
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
    
    init(viewModel: ChangePasswordViewModel){
        let input = ChangePasswordViewModel.Input(
            changePasswordTrigger: self.changePasswordTrigger.asDriver(),
            popViewTrigger: popViewTrigger.asDriver()
        )
        self.output = viewModel.transform(input, cancelBag: cancelBag)
        self.input = input
    }
}

struct ChangePasswordHeaderView : View {
    var body: some View {
        return Text("Change password".localized())
                .font(.title)
                .fontWeight(.semibold)
                .padding(.bottom, 20)
        
    }
}

struct ChangePasswordButtonContent : View {
    var body: some View {
        return Text("Change password".localized())
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 48)
            .background(Color.green)
            .cornerRadius(.greatestFiniteMagnitude)
    }
}

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView(viewModel: PreviewAssembler().resolve(navigationController: UINavigationController()))
    }
}
