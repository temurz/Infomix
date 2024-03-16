//
//  AsyncImageEarly.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 14/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import SwiftUI

struct AsyncImageEarly<Placeholder: View>: View {
    @StateObject private var loader: ImageLoader
     private let placeholder: Placeholder
     private let image: (UIImage) -> Image
     
     init(
         url: URL,
         @ViewBuilder placeholder: () -> Placeholder,
         @ViewBuilder image: @escaping (UIImage) -> Image = Image.init(uiImage:)
     ) {
         self.placeholder = placeholder()
         self.image = image
         _loader = StateObject(wrappedValue: ImageLoader(url: url, cache: Environment(\.imageCache).wrappedValue))
     }
     
     var body: some View {
         content
             .onAppear(perform: loader.load)
     }
     
     private var content: some View {
         Group {
             if loader.image != nil {
                 image(loader.image!)
                     .aspectRatio(contentMode: .fit)
             } else {
                 placeholder
             }
         }
     }
}
