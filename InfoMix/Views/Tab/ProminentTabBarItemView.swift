//
//  ProminentTabBarItemView.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 11/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import SwiftUI

struct ProminentTabBarItemView: View {
  
  let width: CGFloat
  
  private var innerCircleWidth: CGFloat {
    return width - 10
  }
  
  private var imageWidth: CGFloat {
    return innerCircleWidth / 2
  }
  
  private var gradient: LinearGradient {
      let endColor = Color(red: 0.9, green: 0, blue: 0)
    
    let startColor = Color(red: 1, green: 0, blue: 0)
    
    let gradient = Gradient(colors: [startColor, endColor])
    
    return LinearGradient(gradient: gradient, startPoint: .bottomLeading, endPoint: .topTrailing)
  }
  
  let systemImageName: String
  let action: () -> Void
  
  
  var body: some View {
    Button (action: action) {
        ZStack(alignment: .center) {
        Circle()
          .size(CGSize(width: innerCircleWidth, height: innerCircleWidth))
          .fill(.green)
//          .background(Color.green)
          .offset(x: 5, y: 5)
        
        Image(systemName: systemImageName)
          .resizable()
          .frame(width: imageWidth, height: imageWidth)
          .foregroundColor(.white)
      }.frame(width: width, height: width)
    }
  }
}
