//
//  AboutView.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 19/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine

struct AboutView: View {
    
    @ObservedObject var output: AboutViewModel.Output
    
    let callTrigger = PassthroughSubject<Void,Never>()
    let openTelegramTrigger = PassthroughSubject<Void,Never>()
    let popViewTrigger = PassthroughSubject<Void,Never>()

    let cancelBag = CancelBag()
    
    
    var body: some View {
        let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? ""
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        
        return VStack {
            CustomNavigationBar(title: "About".localized()) {
                popViewTrigger.send(())
            }
            ZStack(alignment: .top) {

                Color(.systemGray6)


                ScrollView(.vertical, showsIndicators: false) {

                    VStack(spacing: 5) {
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 128, height: 128)
                        Text(appName)
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding()
                        Text(appVersion)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding()
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 1)
                    .padding(12)

                    VStack(alignment: .leading, spacing: 0) {

                        Text("Contacts".localized())
                            .font(.subheadline)
                            .foregroundColor(.black)
                            .padding()

                        Divider()

                        Button {
                            self.callTrigger.send()
                        } label: {
                            HStack(spacing: 10){
                                    Image(systemName: "phone")
                                        .resizable()
                                        .aspectRatio( contentMode: .fit)
                                        .foregroundColor(.gray)
                                        .frame(width: 18, height: 18)
                                    VStack(alignment: .leading){
                                        Text(output.phone)
                                            .font(.headline)
                                            .foregroundColor(.black)
                                    }
                                Spacer()

                            }.padding()
                                .frame(maxWidth: .infinity)
                                .font(.caption)

                        }

                        Divider()

                        Button {
                            self.openTelegramTrigger.send()
                        } label: {
                            HStack(spacing: 10){
                                Image(systemName: "paperplane.fill")
                                    .resizable()
                                    .aspectRatio( contentMode: .fit)
                                    .foregroundColor(.gray)
                                    .frame(width: 18, height: 18)
                                VStack(alignment: .leading){
                                    Text("We are on telegram".localized())
                                        .font(.headline)
                                        .foregroundColor(.black)

                                }
                                Spacer()

                            }.padding()
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
            .navigationTitle("About".localized())
            .frame(maxHeight: .infinity)

        }
    }
    
    init(viewModel: AboutViewModel){
        let input = AboutViewModel.Input(
            callTrigger: self.callTrigger.asDriver(),
            openTelegramTrigger: self.openTelegramTrigger.asDriver(),
            popViewTrigger: popViewTrigger.asDriver()
        )
        self.output = viewModel.transform(input, cancelBag: cancelBag)
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView(viewModel: PreviewAssembler().resolve(navigationController: UINavigationController()))
    }
}
