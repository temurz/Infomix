//
//  HomeView.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 12/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import SwiftUI
import UIKit
import Combine

struct HomeView: View {
    
    @ObservedObject var output: HomeViewModel.Output
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    private let viewModel: HomeViewModel
    private let cancelBag = CancelBag()
    private let loadTrigger = PassthroughSubject<Void, Never>()
    private let reloadTrigger = PassthroughSubject<Void, Never>()
    private let showTransactionHistoryTrigger = PassthroughSubject<Void, Never>()
    private let showExchangeTrigger = PassthroughSubject<Void, Never>()
    private let showLocalUsersTrigger = PassthroughSubject<Void, Never>()
    private let showEventsTrigger = PassthroughSubject<Void,Never>()
    private let showMyCardsTrigger = PassthroughSubject<Void,Never>()
    private let updateIcuTrigger = PassthroughSubject<Double,Never>()
    private let countDownTrigger = PassthroughSubject<Void, Never>()
    private let selectEventTrigger = PassthroughSubject<EventItemViewModel, Never>()
    private let closeAdEventTrigger = PassthroughSubject<Void,Never>()
    private let sendTokentoServerTrigger = PassthroughSubject<String,Never>()
    
    let icuView: ICUView
    
    var body: some View {
        ZStack(alignment: .top) {
            
            Color(.systemGray6)
            
            RoundedCorner(color: .green, tl: 0, tr: 0, bl: 0, br: 60)
                .frame(maxWidth: .infinity, maxHeight: 240)
            
            
            ScrollView(.vertical, showsIndicators: false) {
                HStack{
                    VStack{
                        
                        Text(output.certificate.agentFullName)
                            .font(.title2)
                            .foregroundColor(.white)
                            .frame(maxWidth:.infinity,alignment: .leading)
                            .padding([.horizontal,.top], 20)
                        
                        Text(String(format: "Certificate: %@".localized(), output.certificate.certificateCode))
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .frame(maxWidth:.infinity,alignment: .leading)
                            .padding(.horizontal, 20)
                        
                    }
                    VStack{
                        Spacer()
                        Button {
                            self.showLocalUsersTrigger.send()
                        } label: {
                            HStack (spacing: 4){
                                Image(systemName: "rectangle.stack.person.crop")
                                Text("Accounts".localized())
                                    .font(.system(size: 12))
                            }
                            .font(.caption)
                            .foregroundColor(.white)
                            .padding(4)
                            .overlay(RoundedRectangle(cornerRadius: 14).stroke().foregroundColor(Color.white))
                        }
                    }.padding(.horizontal,20)
                    
                }
                VStack(spacing: 5) {
                    HStack{
                        Text(String(output.certificate.serviceName).localized())
                            .frame(maxWidth:.infinity,alignment: .leading)
                        Spacer()
                        
                        Button(action: {
                            self.showMyCardsTrigger.send()
                        }, label: {
                            HStack{
                                Text("My cards".localized())
                            }
                            .font(.caption)
                            .foregroundColor(.green)
                            .padding(4)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke().foregroundColor(Color.green))
                            
                        })

                    }.padding(12)
                    
                    
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 96, height: 96)
                    
                    Text("You have".localized())
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    icuView
                        .onReceive(icuView.output.$icu, perform: { icu in
                            updateIcuTrigger.send(icu)
                        })
                    
                        .frame(maxWidth:.infinity)
                    
                    
                    HStack{
                        Button(action: {
                            self.showTransactionHistoryTrigger.send()
                        }) {
                            HStack {
                                Text("History".localized())
                                Image(systemName: "arrow.up.arrow.down.circle")
                            }
                        }
                        .padding(8)
                        .foregroundColor(.white)
                        .background(Color.gray)
                        .cornerRadius(.greatestFiniteMagnitude)
                        
                        
                    }
                    
                    .padding()
                    
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 4)
                .padding(20)
                
                HStack{
                    Text("Last events".localized())
                        .font(.system(size: 20.0))
                        .bold()
                    Spacer()
                    
                    Button(action: {
                        self.showEventsTrigger.send()
                    }){
                        HStack{
                            Text("All events".localized())
                            Image(systemName: "arrow.right")
                        }
                        .font(.caption)
                        .foregroundColor(.green)
                        .padding(4)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke().foregroundColor(Color.green))
                    }
                    
                }.padding(.horizontal)
                ScrollView (.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(output.lastEvents.enumerated().map{ $0 }, id: \.element.title) {
                            index, event in
                            Button(action: {
                                self.selectEventTrigger.send(event)
                            }) {
                                EventRow(viewModel: event)
                                    .frame(width: UIScreen.main.bounds.width * 2 / 3)
                            }.padding(4)
                        }
                    }
                }.padding(.horizontal)
                    .padding(.bottom, 40)
                
                
            }.padding(.top, 40)
            
            
            if !output.shownAdEvent && output.adEvent != nil && output.adTimeRemaining > 0 {
                ZStack{
                    Color(.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.80))
                    VStack(alignment: .trailing){
                        HStack{
                            Text("\(output.adTimeRemaining) s")
                                .foregroundColor(.white)
                                .bold()
                                .padding(.horizontal)
                            Spacer()
                            Button {
                                self.closeAdEventTrigger.send()
                            } label: {
                                Image(systemName: "xmark")
                                    .foregroundColor(.red)
                            }.padding()

                        }
                                                
                        Button {
                            if let event = output.adEvent {
                                self.selectEventTrigger.send(event)
                            }
                        } label: {
                            if let url = URL(string: self.output.adEvent?.imageUrl ?? "") {
                                if #available(iOS 15.0, *) {
                                    AsyncImage(url: url) { image in
                                        image
                                            .resizable()
                                            .scaledToFit()
                                    } placeholder: {
                                        ProgressView()
                                    }.padding()
                                } else {
                                    AsyncImageEarly(
                                        url: url,
                                        placeholder: { ProgressView() },
                                        image: { Image(uiImage: $0)
                                                .resizable()
                                        }
                                    ).padding()
                                }
                            }
                        }
                    }
                }
            }
            
            
        } .onReceive(timer) { _ in
            guard !output.shownAdEvent else {
                return
            }
            if output.adTimeRemaining > 0 {
                self.countDownTrigger.send(())
            }
        }
        
    }
    
    init(viewModel: HomeViewModel, homeAttechedViews: HomeAttachedViewType) {
        
        let iv =  homeAttechedViews.getICUView()
        
        self.viewModel = viewModel
        let input = HomeViewModel.Input(
            showLocalUsersTrigger: self.showLocalUsersTrigger.asDriver(),
                                        showTransactionHistoryTrigger: showTransactionHistoryTrigger.asDriver(),
                                        showExchangeTrigger: showExchangeTrigger.asDriver(),
                                        loadTrigger: loadTrigger.asDriver(),
                                        reloadTrigger: reloadTrigger.asDriver(),
                                        showEventsTrigger: showEventsTrigger.asDriver(), showMyCardsTrigger: showMyCardsTrigger.asDriver(),
                                        countDownTrigger: countDownTrigger.asDriver(),
            selectEventTrigger: selectEventTrigger.asDriver(), closeAdEventTrigger: closeAdEventTrigger.asDriver(), sendFcmTokenTrigger: sendTokentoServerTrigger.asDriver()
        )
        self.output = viewModel.transform(input, cancelBag: cancelBag)
        self.icuView = iv
        
        loadTrigger.send(())
        
        if let token = UserDefaults.standard.string(forKey: "fcmToken"){
            sendTokentoServerTrigger.send(token)
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel: HomeViewModel = PreviewAssembler().resolve(navigationController: UINavigationController(), cardConfig: CardConfig(configCode: ""))
        let homeAttachedViews: HomeAttachedViewType = PreviewAssembler().resolve()
        return HomeView(viewModel: viewModel, homeAttechedViews: homeAttachedViews)
    }
}
