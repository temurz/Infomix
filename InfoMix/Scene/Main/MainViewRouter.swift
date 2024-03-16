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
}


class MainViewRouter: ViewRouter, ShowingEventList, ShowingAddCard{
    let navigationController: UINavigationController
    let assembler: Assembler
    let homeView: HomeView
    let notificationsView : NotificationsView
    let cardConfig: CardConfig
    
    
    var pages: [TabBarItem] = [TabBarItem(imageName: "homekit", title: "Home", id: MainPage.home.rawValue),
                               TabBarItem(imageName: "wand.and.stars", title: "Bonus", id: MainPage.bonus.rawValue),
                               TabBarItem(imageName: "bell.fill", title: "Notification", id: MainPage.notification.rawValue),
                               TabBarItem(imageName: "person.circle", title: "Profile", id: MainPage.profile.rawValue)]
    
    @Published var selectedPageId: String = MainPage.home.rawValue
    @Published var body: AnyView
    
    func route(selectedPageId: String) {
        self.selectedPageId = selectedPageId
        switch selectedPageId {
        case MainPage.home.rawValue:
           
            body = AnyView(homeView)
            break
        case MainPage.bonus.rawValue:
            var certificate = homeView.output.certificate
            certificate.balance = homeView.icuView.output.icu
            let v:ShoppingView = assembler.resolve(navigationController: navigationController, certificate: certificate)
            body = AnyView(v)
            break
        case MainPage.notification.rawValue:
            let v:NotificationsView = assembler.resolve(navigationController: navigationController)
            body = AnyView(v)
            break
        case MainPage.profile.rawValue:
            var certificate = homeView.output.certificate
            certificate.balance = homeView.icuView.output.icu
            certificate.cardConfig = cardConfig
            let profileView: ProfileView = assembler.resolve(navigationController: navigationController, certificate: certificate)
            body = AnyView(profileView)
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
