//
//  ProfileView.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 15/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine

struct ProfileView: View {
    
    @ObservedObject var output: ProfileViewModel.Output
    let cancelBag = CancelBag()
    
    let logoutTrigger = PassthroughSubject<Void, Never>()
    let openChangePasswordTrigger = PassthroughSubject<Void, Never>()
    let openLanguageSettingsTrigger = PassthroughSubject<Void, Never>()
    let openNotificationSettingsTrigger = PassthroughSubject<Void, Never>()
    let showAboutTrigger = PassthroughSubject<Void, Never>()
    let exitTrigger = PassthroughSubject<Void, Never>()
    
    var body: some View {
        ZStack(alignment: .top) {

            Color(.systemGray6)

            RoundedCorner(color: Colors.appMainColor, tl: 0, tr: 0, bl: 0, br: 60)
                .frame(maxWidth: .infinity, maxHeight: 240)


            ScrollView(.vertical, showsIndicators: false) {

                VStack(spacing: 5) {

                    Text("Certificate".localized() + " \(output.certificate.certificateCode)")
                        .font(.subheadline)
                        .foregroundColor(.black)
                        .padding()

                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .foregroundColor(Color(.systemBlue))
                        .frame(width: 64, height: 64)

                    Text(output.certificate.agentFullName)
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding()

                    HStack{
                        Image(systemName: "circle.fill")
                            .resizable()
                            .foregroundColor((output.certificate.certificate?.blocked ?? true) ? .red : .green)
                            .frame(width: 12, height: 12)

                        Text((output.certificate.certificate?.blocked ?? true) ? "Blocked".localized() : "Active".localized())
                            .foregroundColor((output.certificate.certificate?.blocked ?? true) ? .red : .green)
                    }.padding(.horizontal)
                        .font(.caption)

                    Text(output.certificate.phoneNumber)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.horizontal)

                    Button(action: {
                        self.logoutTrigger.send()
                    }) {
                        HStack {
                            Text("Delete account".localized())
                            Image(systemName: "power")
                        }.padding(8)
                            .font(.caption)
                            .foregroundColor(.white)
                            .background(Color.red)
                            .cornerRadius(.greatestFiniteMagnitude)
                    }
                    .padding()

                }
                .frame(maxWidth: .infinity, alignment: .center)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 1)
                .padding(12)

                VStack(alignment: .leading, spacing: 0) {

                    Text("Profile".localized())
                        .font(.subheadline)
                        .foregroundColor(.black)
                        .padding()

                    Divider()

                    Button {
                        self.openChangePasswordTrigger.send()
                    } label: {
                        HStack(spacing: 10){
                            Image(systemName: "lock")
                                .resizable()
                                .aspectRatio( contentMode: .fit)
                                .foregroundColor(.gray)
                                .frame(width: 24, height: 24)
                            VStack(alignment: .leading){
                                Text("Change password".localized())
                                    .font(.headline)
                                    .foregroundColor(.black)
                                Text("Press to change password".localized())
                                    .font(.caption)
                                    .foregroundColor(Color(.systemGray))
                            }
                            Spacer()

                        }.padding(10)
                            .frame(maxWidth: .infinity)
                            .font(.caption)

                    }

                }
                .frame(maxWidth: .infinity, alignment: .center)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 1)
                .padding(12)


                VStack(alignment: .leading, spacing: 0) {

                    Text("Settings".localized())
                        .font(.subheadline)
                        .foregroundColor(.black)
                        .padding()

                    Divider()

                    Button {
                        self.openLanguageSettingsTrigger.send()
                    } label: {
                        HStack(spacing: 10){
                            Image(systemName: "globe")
                                .resizable()
                                .aspectRatio( contentMode: .fit)
                                .foregroundColor(.gray)
                                .frame(width: 24, height: 24)
                            VStack(alignment: .leading){
                                Text("Language".localized())
                                    .font(.headline)
                                    .foregroundColor(.black)
                                Text("System language".localized())
                                    .font(.caption)
                                    .foregroundColor(Color(.systemGray))
                            }
                            Spacer()

                        }.padding(10)
                            .frame(maxWidth: .infinity)
                            .font(.caption)

                    }

                    Divider()



                    Toggle(isOn: $output.isEnabledNotification) {
                        HStack(spacing: 10){
                            Image(systemName: "bell")
                                .resizable()
                                .aspectRatio( contentMode: .fit)
                                .foregroundColor(.gray)
                                .frame(width: 24, height: 24)
                            VStack(alignment: .leading){
                                Text("Notification".localized())
                                    .font(.headline)
                                    .foregroundColor(.black)
                                Text("Enabled".localized())
                                    .font(.caption)
                                    .foregroundColor(Color(.systemGray))
                            }

                        }
                        .font(.caption)
                    }.padding(10)
                        .frame(maxWidth: .infinity)





                    Divider()

                    Button {
                        self.showAboutTrigger.send()
                    } label: {
                        HStack(spacing: 10){
                            Image(systemName: "ellipsis")
                                .resizable()
                                .aspectRatio( contentMode: .fit)
                                .foregroundColor(.gray)
                                .frame(width: 24, height: 24)
                            VStack(alignment: .leading){
                                Text("About".localized())
                                    .font(.headline)
                                    .foregroundColor(.black)
                                Text("Version, Information, Contacts".localized())
                                    .font(.caption)
                                    .foregroundColor(Color(.systemGray))
                            }
                            Spacer()

                        }.padding(10)
                            .frame(maxWidth: .infinity)
                            .font(.caption)

                    }

                }
                .frame(maxWidth: .infinity, alignment: .center)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 1)
                .padding(12)

                Spacer()
                    .frame(height: 48)
            }.padding(.top, 48)
        }
        .frame(maxHeight: .infinity)
        .onAppear {
            output.certificate = output.certificate
        }
    }
    
    init(viewModel: ProfileViewModel){
        let input = ProfileViewModel.Input(logoutTrigger: self.logoutTrigger.asDriver(), openChangePasswordTrigger: self.openChangePasswordTrigger.asDriver(), openLanguageSettingTrigger: self.openLanguageSettingsTrigger.asDriver(), openNotificationSettingTrigger: self.openNotificationSettingsTrigger.asDriver(), showAboutTrigger: self.showAboutTrigger.asDriver(), exitTrigger: self.exitTrigger.asDriver())
        self.output = viewModel.transform(input, cancelBag: cancelBag)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(viewModel: PreviewAssembler().resolve(navigationController: UINavigationController(), certificate: CertificateItemViewModel(certificate: Certificate(id: 1, certificate: "0001", master: Master(id: 1, firstName: "Damir", fathersName: "Asamatdinov", lastName: "Asamatdinov", phone: "+99891 381 05 99", birthday: nil, status: nil), service: Job(id: 1, name: "O'rnatish", icon: nil), dailyLimitCard: 0, unreadNotification: 0, expired: false, blocked: false, needUpgradeConfig: false))))
    }
}
