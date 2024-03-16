//
//  Image+.swift
//  CleanArchitecture
//
//  Created by Temur on 22/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import SwiftUI
extension Image {
    func centerCropped() -> some View {
        GeometryReader { geo in
            self
            .resizable()
            .scaledToFill()
            .frame(width: geo.size.width, height: geo.size.height)
            .clipped()
        }
    }
}
