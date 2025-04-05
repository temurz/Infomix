//
//  TabBarItemView.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 11/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//
import SwiftUI

//struct TabBarItemView<Router>: View where Router: ViewRouter{
//  
//    @StateObject var viewRouter: Router
//  
//  let tabBarItem: TabBarItem
//  let defaultColor: Color
//  let selectedColor: Color
//  let width, height: CGFloat
//  
//  let font : Font
//  
//  private var displayColor: Color {
//    selected ? selectedColor : defaultColor
//  }
//  
//  private var selected: Bool {
//      viewRouter.selectedPageId == tabBarItem.id
//  }
//  
//  var body: some View {
//    VStack {
//      Image(tabBarItem.imageName)
//        .renderingMode(.template)
//        .resizable()
//        .foregroundColor(displayColor)
//        .aspectRatio(contentMode: .fit)
//        .frame(width: width, height: height)
//        .padding(.top, 20)
//        Text(tabBarItem.title.localized())
//        .font(font)
//        .foregroundColor(displayColor)
//        Spacer()
//    }.padding(.horizontal, -4)
//    .onTapGesture {
//        viewRouter.route(selectedPageId: tabBarItem.id)
//    }
//  }
//}

struct TabBarItemView<Router>: View where Router: ViewRouter {
    
    @StateObject var viewRouter: Router
    
    let tabBarItem: TabBarItem
    let defaultColor: Color
    let selectedColor: Color
    let width, height: CGFloat
    
    let font : Font
    
    var isProminent = false
    
    private var displayColor: Color {
      selected ? selectedColor : defaultColor
    }
    
    private var selected: Bool {
        viewRouter.selectedPageId == tabBarItem.id
    }
    
    private var displayBackgroundColor: Color {
        .clear
    }
    
    var body: some View {
        VStack {
            if isProminent {
                VStack(spacing: 4) {
                    ZStack(alignment: .center) {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(selectedColor)
                        Image(tabBarItem.imageName)
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 24, height: 24)
                            .foregroundColor(.white)
                    }
                    .frame(width: 48, height: 48)
                    Text(tabBarItem.title)
                        .font(selected ? font.bold() : font)
                        .foregroundStyle(.white)
                    
                }
            } else {
                VStack(spacing: 4) {
                    Image(tabBarItem.imageName)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(displayColor)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: width, height: height)
                        .background(displayBackgroundColor)
                        .cornerRadius(10)
                    Text(tabBarItem.title)
                        .font(selected ? font.bold() : font)
                        .foregroundColor(displayColor)
                    
                }
            }
        }
        .padding(.top, 12)
        .onTapGesture {
            viewRouter.route(selectedPageId: tabBarItem.id)
        }
    }
}
