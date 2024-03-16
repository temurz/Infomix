//
//  TabBarView.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 11/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import SwiftUI

extension Color {
    static let tabBarColor = Color("tabBarColor")
    
    static let tabBarItemDefaultTintColor = Color("tabBarItemDefaultTintColor")
    
    static let tabBarItemSelectedTintColor = Color("tabBarItemSelectedTintColor")
}

extension Font {
    static func nunitoBold(size: Double) -> Font {
        return Font.custom("Nunito-Bold", size: CGFloat(size))
    }
}


struct TabBarView<Router>: View where Router: ViewRouter {
    
    @StateObject var viewRouter: Router
    
    private let cornerRadius: CGFloat = 16
    private let height: CGFloat = 95
    private let shadowRadius: CGFloat = 16
    
    private let prominentItemWidth: CGFloat = 70
    
    private var prominentItemTopPadding: CGFloat {
        return -prominentItemWidth
    }
    
    let prominentItemImageName: String
    let prominentItemAction: () -> Void
    
    
    var body: some View {
        GeometryReader { geo in
            HStack {
                Spacer()
                    ForEach(0..<2) { idx in
                        TabBarItemView(viewRouter: viewRouter,
                                       tabBarItem: self.viewRouter.pages[idx],
                                       defaultColor: .tabBarItemDefaultTintColor,
                                       selectedColor: .green,
                                       width: 30,
                                       height: 30,
                                       font: .caption2)
                            .frame(width: geo.size.width/5.5, height: geo.size.height/28)
                    }
            
                

                if !prominentItemImageName.isEmpty {
                    ProminentTabBarItemView(width: geo.size.width/5.5, systemImageName: prominentItemImageName, action: prominentItemAction)
                        .offset(y: -geo.size.height/8/2-geo.size.width/6/2)
                }
                
                ForEach(2..<self.viewRouter.pages.count) { idx in
                    TabBarItemView(viewRouter: viewRouter,
                                   tabBarItem: self.viewRouter.pages[idx],
                                   defaultColor: .tabBarItemDefaultTintColor,
                                   selectedColor: .green,
                                   width: 30,
                                   height: 30,
                                   font: .caption2)
                        .frame(width: geo.size.width/6, height: geo.size.height/28)
                }
                Spacer()
                
            }
        }
    }
    
   
}

