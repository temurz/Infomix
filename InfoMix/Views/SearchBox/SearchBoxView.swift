//
//  SearchBoxView.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 09/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import SwiftUI

struct SearchBoxView: View {
    @Binding var text: String
    
       @State private var isEditing = true
    
       var body: some View {
           HStack {
    
               TextField("Search ...", text: $text)
                   .padding(8)
                   .padding(.horizontal, 25)
                   .background(Color(.systemGray6))
                   .cornerRadius(8)
                   .padding(.horizontal, 10)
                   .onTapGesture {
                       self.isEditing = true
                   }
               .overlay(
                   HStack {
                       Image(systemName: "magnifyingglass")
                           .foregroundColor(.gray)
                           .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                           .padding(.leading, 12)
                
                       if isEditing {
                           Button(action: {
                               self.text = ""
                           }) {
                               Image(systemName: "multiply.circle.fill")
                                   .foregroundColor(.gray)
                                   .padding(.trailing, 12)
                           }
                       }
                   }
               )
    
               if isEditing {
                   Button(action: {
                       self.isEditing = false
                       self.text = ""
    
                   }) {
                       Text("Cancel")
                   }
                   .padding(.trailing, 10)
                   .transition(.move(edge: .trailing))
                   .animation(.default)
               }
           }
       }
}

struct SearchBoxView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBoxView(text: .constant(""))
    }
}
