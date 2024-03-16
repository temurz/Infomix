//
//  EditFieldStepView.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 15/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import SwiftUI
import iPhoneNumberField

struct EditFieldStepView: AbstractStepView {
    @Binding var cardStepItem: AddCardStepItem
    
    var onDelete: DeleteHandler?
    
    var body: some View {
        VStack {
            
            HStack{
                Text(cardStepItem.titleLocalization())
                Spacer()
                Menu{
                    if cardStepItem.type != .EDIT_TEXT_PHONE{
                    Button("Clear", action: {
                        cardStepItem.valueString = ""
                    })
                    }
                    if cardStepItem.originaltemId != nil {
                        Button("Delete", action:{
                            onDelete?(cardStepItem)
                        })
                    }
                } label: {
                    Image(systemName: "ellipsis")
                        .padding(10)
                }
            }.padding()
                .onTapGesture {
                    hideKeyboard()
                }
            
            if cardStepItem.type == AddCardStepItemType.EDIT_TEXT_MULTILINE{
                TextEditor(text: $cardStepItem.valueString)
                    .foregroundColor(.secondary)
                    .textFieldStyle(.roundedBorder)
                    .frame(maxWidth: .infinity, minHeight: 50, maxHeight: 100, alignment: .topLeading)
                    .padding()
            }  else if cardStepItem.type == AddCardStepItemType.EDIT_TEXT_PHONE{
                iPhoneNumberField("00 000 00 00", text: $cardStepItem.valueString)
                    .defaultRegion("UZ")
                    .flagHidden(false)
                    .maximumDigits(9)
                    .clearButtonMode(.whileEditing)
                    .frame(maxWidth: .infinity)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.phonePad)
                    .padding()
            } else {
                
                TextField("Type here", text: $cardStepItem.valueString)
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(cardStepItem.keyboardPad())
                    .padding()
            }
            
            
            
            
            
            
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 2)
    }
    
    
    
    
}

struct EditFieldStepView_Previews: PreviewProvider {
    
    @State  static var item = AddCardStepItem()
    static var previews: some View {
        EditFieldStepView(cardStepItem: $item)
    }
}
