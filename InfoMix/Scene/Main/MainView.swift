//
//  HomeView.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 11/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewRouter: MainViewRouter
    
   
    var body: some View {
        GeometryReader{ geometry in
            VStack(spacing: 0) {
               viewRouter.body
                    .frame(maxHeight: .infinity)
                    .background(Color(.systemGray6))
                 TabBarView(viewRouter: viewRouter, prominentItemImageName: "") {
//                     self.viewRouter.showAddCard()
                 }
                 .frame(width: geometry.size.width, height: geometry.size.height/10)
                 .background(Color("tabBarColor").shadow(radius: 2))
                
            }
        }
        .onAppear(perform: {
            if self.viewRouter.selectedPageId == MainPage.profile.rawValue {
                self.viewRouter.route(selectedPageId: self.viewRouter.selectedPageId)
            }
        })
        .navigationBarHidden(true)
//            .statusBar(hidden: true)
            .edgesIgnoringSafeArea(.all)
         
    }
   
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        let viewRouter: MainViewRouter = PreviewAssembler().resolve(navigationController: UINavigationController(),cardConfig: CardConfig(configCode: "AA002"))
        
       return MainView(viewRouter: viewRouter)
    }
}
