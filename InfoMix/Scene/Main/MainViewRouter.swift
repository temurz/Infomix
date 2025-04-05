//
//  HomeViewRouter.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 11/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import Combine
import SwiftUI
import Alamofire

enum MainPage: String{
    case home
    case notification
    case bonus
    case profile
    case add
}


class MainViewRouter: ViewRouter, ShowingEventList, ShowingAddCard {
    let navigationController: UINavigationController
    let assembler: Assembler
    let homeView: HomeView
    let notificationsView : NotificationsView
    let cardConfig: CardConfig
    
    
    var pages: [TabBarItem] = [TabBarItem(imageName: "house_tab_icon", title: "Home", id: MainPage.home.rawValue),
                               TabBarItem(imageName: "news_tab_icon", title: "Event List", id: MainPage.bonus.rawValue),
                               TabBarItem(imageName: "scan-qr-code", title: "", id: MainPage.add.rawValue),
                               TabBarItem(imageName: "chat_tab_icon", title: "Chat", id: MainPage.notification.rawValue),
                               TabBarItem(imageName: "user_tab_icon", title: "Profile", id: MainPage.profile.rawValue)]

    @Published var selectedPageId: String = MainPage.home.rawValue
    @Published var body: AnyView
    
    func route(selectedPageId: String) {
        self.selectedPageId = selectedPageId
        switch selectedPageId {
        case MainPage.home.rawValue:
           
            body = AnyView(homeView)
            break
        case MainPage.bonus.rawValue:
//            var certificate = homeView.output.certificate
//            certificate.balance = homeView.icuView.output.icu
            let v:EventsView = assembler.resolve(navigationController: navigationController)
            body = AnyView(v)
            break
        case MainPage.notification.rawValue:
            let v:PollView = PollView()
            body = AnyView(v)
            break
        case MainPage.profile.rawValue:
            var certificate = homeView.output.certificate
            certificate.balance = homeView.icuView.output.icu
            certificate.cardConfig = cardConfig
            let profileView: ProfileView = assembler.resolve(navigationController: navigationController, certificate: certificate)
            body = AnyView(profileView)
        case MainPage.add.rawValue:
            break
        default:
            body = AnyView(Text("DEFAULT"))
            break
        }
    }
    
    init(assembler: Assembler, navigationController: UINavigationController, cardConfig: CardConfig){
        self.navigationController  = navigationController
        self.assembler = assembler
        self.homeView = assembler.resolve(navigationController: navigationController, cardConfig: cardConfig)
        self.body = AnyView(self.homeView)
        self.cardConfig = cardConfig
        self.notificationsView = assembler.resolve(navigationController: navigationController)
    }
    
}
