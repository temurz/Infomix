//
//  TabBarItemView.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 11/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//
import SwiftUI

struct TabBarItemView<Router>: View where Router: ViewRouter{
  
    @StateObject var viewRouter: Router
  
  let tabBarItem: TabBarItem
  let defaultColor: Color
  let selectedColor: Color
  let width, height: CGFloat
  
  let font : Font
  
  private var displayColor: Color {
    selected ? selectedColor : defaultColor
  }
  
  private var selected: Bool {
      viewRouter.selectedPageId == tabBarItem.id
  }
  
  var body: some View {
    VStack {
      Image(tabBarItem.imageName)
        .renderingMode(.template)
        .resizable()
        .foregroundColor(displayColor)
        .aspectRatio(contentMode: .fit)
        .frame(width: width, height: height)
        .padding(.top, 20)
        Text(tabBarItem.title.localized())
        .font(font)
        .foregroundColor(displayColor)
        Spacer()
    }.padding(.horizontal, -4)
    .onTapGesture {
        viewRouter.route(selectedPageId: tabBarItem.id)
    }
  }
}
