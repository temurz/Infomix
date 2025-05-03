//
//  BottomSheetView.swift
//  InfoMix
//
//  Created by Temur on 02/05/2025.
//  Copyright © 2025 InfoMix. All rights reserved.
//

import SwiftUI

struct BottomSheetView<Content: View>: View {
    
    @Binding var isShowing: Bool
    var onDismiss: (() -> Void)?
    let content: () -> Content
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            
            if isShowing {
                Color.black
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            isShowing = false
                        }
                        onDismiss?()
                    }
                
                VStack {
                    
                    content()
                        .padding(.bottom)
                }
                .frame(maxWidth: .infinity)
                .background(.white)
                .cornerRadius(radius: 16, corners: .topLeft)
                .cornerRadius(radius: 16, corners: .topRight)
                .transition(.move(edge: .bottom))
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
        .animation(.easeInOut, value: isShowing)
        
    }
}
