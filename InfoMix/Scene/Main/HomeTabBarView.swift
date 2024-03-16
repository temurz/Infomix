//
//  HomeTabBarView.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 11/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import Combine
import SwiftUI

struct HomeTabBarView: View{
    
    @StateObject var viewRouter: HomeViewRouter
      
    private let cornerRadius: CGFloat = 16
    private let height: CGFloat = 95
    private let shadowRadius: CGFloat = 16
    
    private let prominentItemWidth: CGFloat = 70
    
    private var prominentItemTopPadding: CGFloat {
      return -prominentItemWidth
    }
    
    let tabBarItems: [TabBarItem]
    let prominentItemImageName: String
    let prominentItemAction: () -> Void
    
    @State var selectedIndex = 0
    
    var body: some View {
      ZStack {
        containerBox
       
        tabBarItemsView
      }
    }
      
      private var containerBox: some View{
          Rectangle()
              .fill(Color.tabBarColor)
              .cornerRadius(cornerRadius)
              .frame(height: height)
              .shadow(radius: shadowRadius)
      }
      
      private var tabBarItemsView: some View {
         GeometryReader { geo in
           HStack {
               Spacer()
             ForEach(0..<2) { idx in
               TabBarItemView(tabBarItem: self.tabBarItems[idx],
                              selectedIndex: self.selectedIndex,
                              tabBarIndex: idx,
                              defaultColor: .tabBarItemDefaultTintColor,
                              selectedColor: .tabBarItemSelectedTintColor,
                              font: .nunitoBold(size: 14))
                 .frame(width: self.tabBarItemWidth(from: geo))
                 .onTapGesture {
                   self.selectedIndex = idx
               }
             }
             
               ProminentTabBarItemView()
             
             ForEach(2..<self.tabBarItems.count) { idx in
               TabBarItemView(tabBarItem: self.tabBarItems[idx],
                              selectedIndex: self.selectedIndex,
                              tabBarIndex: idx,
                              defaultColor: .tabBarItemDefaultTintColor,
                              selectedColor: .tabBarItemSelectedTintColor,
                              font: .nunitoBold(size: 14))
                 .frame(width: self.tabBarItemWidth(from: geo))
                 .onTapGesture {
                   self.selectedIndex = idx
               }
             }
               Spacer()
           }
         }
       }
}
