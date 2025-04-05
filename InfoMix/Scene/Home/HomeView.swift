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
import Localize_Swift
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
    private let getLoyaltyTrigger = PassthroughSubject<Void,Never>()
    private let getStatisticsTrigger = PassthroughSubject<Void,Never>()
    private let showAddCardTrigger = PassthroughSubject<Void,Never>()
    private let showShoppingViewTrigger = PassthroughSubject<Void,Never>()
    private let showNotificationsTrigger = PassthroughSubject<Void,Never>()
    private let showStatusViewTrigger = PassthroughSubject<Void,Never>()

    let icuView: ICUView
    
    var body: some View {
        ZStack(alignment: .top) {
            Colors.appMainColor
                .frame(maxWidth: .infinity)
                .frame(maxHeight: .infinity)
            VStack {
                HStack {
                    Button {
                        showStatusViewTrigger.send(())
                    } label: {
                        if let iconUrl = output.loyalty?.icon {
                            if let url = URL(string: iconUrl) {
                                AsyncImage(url: url) { image in
                                    image
                                        .resizable()
                                        .centerCropped()
                                        .frame(width: 36, height: 36)
                                        .cornerRadius(radius: 18, corners: .allCorners)
                                } placeholder: {
                                    ProgressView()
                                }
                            }
                        } else {
                            Image("na_icon")
                                .resizable()
                                .centerCropped()
                                .frame(width: 36, height: 36)
                                .cornerRadius(radius: 18, corners: .allCorners)
                        }
                    }
                    .frame(width: 36, height: 36)
                    .background(.white)
                    .cornerRadius(radius: 18, corners: .allCorners)
                    .padding(.vertical)
                    VStack {
                        Text(output.certificate.agentFullName)
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth:.infinity,alignment: .leading)
                        Text(String(format: "Certificate: %@".localized(), output.certificate.certificateCode))
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .frame(maxWidth:.infinity,alignment: .leading)
                    }
                    Button {
                        showNotificationsTrigger.send(())
                    } label: {
                        Image(systemName: "bell.fill")
                            .resizable()
                            .foregroundStyle(Colors.appMainColor)
                            .padding(8)
                    }
                    .frame(width: 36, height: 36)
                    .background(.white)
                    .cornerRadius(radius: 18, corners: .allCorners)
                    .padding(.vertical)
                }
                .padding()
                Text("My balance".localized())
                    .font(.subheadline)
                    .foregroundColor(.white)
                
                icuView
                    .onReceive(icuView.output.$icu, perform: { icu in
                        output.certificate.balance = icu
                        updateIcuTrigger.send(icu)
                    })
                
                    .frame(maxWidth:.infinity)
                
                HStack(alignment: .top) {
                    Spacer()
//                    VStack(spacing: 0) {
//                        Button {
//                            showAddCardTrigger.send(())
//                        } label: {
//                            Image("plus")
//                                .renderingMode(.template)
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
//                                .foregroundStyle(.white)
//                                .padding()
//                        }
//                        .frame(width: 60, height: 60)
//                        .background(Color.black.opacity(0.2))
//                        .cornerRadius(radius: 30, corners: .allCorners)
//                        .padding([.horizontal, .top])
//                        Text("Add Card".localized())
//                            .font(.callout)
//                            .bold()
//                            .multilineTextAlignment(.center)
//                            .lineLimit(2)
//                            .foregroundStyle(.white)
//                    }
//                    .frame(width: UIScreen.screenWidth/3 - 8)
                    if output.cardConfig.hasShop {
                        VStack(spacing: 0) {
                            Button {
                                showShoppingViewTrigger.send(())
                            } label: {
                                Image("shopping_bag")
                                    .renderingMode(.template)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundStyle(.white)
                                    .padding()
                            }
                            .frame(width: 60, height: 60)
                            .background(Color.black.opacity(0.2))
                            .cornerRadius(radius: 30, corners: .allCorners)
                            .padding([.horizontal, .top])
                            Text("Shop".localized())
                                .font(.callout)
                                .bold()
                                .multilineTextAlignment(.center)
                                .lineLimit(2)
                                .foregroundStyle(.white)
                        }
                        .frame(width: UIScreen.screenWidth/3 - 8)
                    }
//                    if output.cardConfig.hasPayment {
//                        VStack(spacing: 0) {
//                            Button {
//                                showShoppingViewTrigger.send(())
//                            } label: {
//                                Image("shopping_bag")
//                                    .renderingMode(.template)
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fit)
//                                    .foregroundStyle(.white)
//                                    .padding()
//                            }
//                            .frame(width: 60, height: 60)
//                            .background(Color.black.opacity(0.2))
//                            .cornerRadius(radius: 30, corners: .allCorners)
//                            .padding([.horizontal, .top])
//                            Text("Shop".localized())
//                                .font(.callout)
//                                .bold()
//                                .lineLimit(2)
//                                .foregroundStyle(.white)
//                        }
//                        .frame(width: UIScreen.screenWidth/3 - 8)
//
//                    }

                    Spacer()
                }
                
                
                
                
                VStack(spacing: 5) {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: UIScreen.screenWidth/2, maximum: UIScreen.screenWidth/2)), GridItem(.adaptive(minimum: UIScreen.screenWidth/2, maximum: UIScreen.screenWidth/2))]) {
                            ForEach(output.items, id: \.subtitle) { item in
                                MainCellView(model: item)
                                    .frame(maxWidth: .infinity)
                                    .cornerRadius(8)
                                    .padding(4)
                                    .onTapGesture {
                                        cellTapped(item.type)
                                    }
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                    .padding(8)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .frame(maxHeight: .infinity)
                .background(Color.white)
                .cornerRadius(radius: 10, corners: [.topLeft, .topRight])
                .shadow(radius: 4)
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
            
            
        }
        .onAppear(perform: {
            getLoyaltyTrigger.send(())
            getStatisticsTrigger.send(())
        })
        .onReceive(timer) { _ in
            guard !output.shownAdEvent else {
                return
            }
            if output.adTimeRemaining > 0 {
                self.countDownTrigger.send(())
            }
        }
        
    }

    private func cellTapped(_ type: MainCellType)  {
        switch type {
        case .confirmed:
            showMyCardsTrigger.send(())
        default:
            break
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
            showEventsTrigger: showEventsTrigger.asDriver(),
            showMyCardsTrigger: showMyCardsTrigger.asDriver(),
            countDownTrigger: countDownTrigger.asDriver(),
            selectEventTrigger: selectEventTrigger.asDriver(), 
            closeAdEventTrigger: closeAdEventTrigger.asDriver(),
            sendFcmTokenTrigger: sendTokentoServerTrigger.asDriver(),
            getLoyaltyTrigger: getLoyaltyTrigger.asDriver(),
            getStatisticsTrigger: getStatisticsTrigger.asDriver(),
            showAddCardTrigger: showAddCardTrigger.asDriver(),
            showShoppingViewTrigger: showShoppingViewTrigger.asDriver(),
            showNotificationsTrigger: showNotificationsTrigger.asDriver(),
            showStatusViewTrigger: showStatusViewTrigger.asDriver()
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
