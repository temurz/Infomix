//
//  BarcodeEditableStepView.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 15/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine

struct BarcodeEditableStepView: AbstractStepView {
    
    @Binding var cardStepItem :AddCardStepItem
    var scanTrigger: PassthroughSubject<AddCardStepItem,Error>
    var onDelete: DeleteHandler?
    
    var body: some View {
        VStack {
            
            HStack{
                Text(cardStepItem.titleLocalization())
                Spacer()
                Menu{
                    Button("Clear", action: {
                        cardStepItem.valueString = ""
                    })
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
            if cardStepItem.editable {
                HStack{
                    TextField("Type here", text: $cardStepItem.valueString)
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .textFieldStyle(.roundedBorder)
                    
                    Button{
                        self.scanTrigger.send(cardStepItem)
                    } label: {
                        Image(systemName: "qrcode.viewfinder").padding(8)
                            .background(Color(red: 0.82, green: 0.82, blue: 0.82).cornerRadius(8))
                    }
                    
                    
                }.padding()
            } else {
                VStack{
                    Text(cardStepItem.valueString)
                    Button{
                        self.scanTrigger.send(cardStepItem)
                    } label: {
                        HStack{
                            Image(systemName: "qrcode.viewfinder")
                            Text("Scan")
                        }.padding(10)
                            .frame(maxWidth: .infinity)
                            .background(Color(red: 0.82, green: 0.82, blue: 0.82).cornerRadius(8))
                    }.padding()
                }
                
            }
            
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 2)
    }
    
    
    func scan() {
        
    }
    
}

struct BarcodeEditableStepView_Previews: PreviewProvider {
    
    @State  static var item = AddCardStepItem()
    static var previews: some View {
        BarcodeEditableStepView(cardStepItem: $item, scanTrigger: PassthroughSubject<AddCardStepItem, Error>())
    }
}
