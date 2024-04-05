//
//  StepView.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 22/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine

struct StepView: View {
    @Binding var addCardStep: AddCardStep
    @State var editableCardStep: AddCardStep
    let scanTrigger: PassthroughSubject<AddCardStepItem,Error>
    
    var body: some View {
        ScrollView {
            LazyVStack{
                
                    ForEach($addCardStep.items) { item in
                        VStack(alignment: .trailing) {
                            switch (item.type.wrappedValue) {
                            case AddCardStepItemType.EDIT_TEXT_BARCODE:
                                BarcodeEditableStepView(cardStepItem: item, scanTrigger: self.scanTrigger) { addCardStepItem in
                                    self.addCardStep.removeCloneStepItem(addCardStepItem)
                                }
                            case AddCardStepItemType.CHOOSE_PHOTO:
                                ImageFieldStepView(cardStepItem: item)
                                    .onAppear {
                                        UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
                                    }
                            default:
                                EditFieldStepView(cardStepItem: item) { addCardStepItem in
                                    self.addCardStep.removeCloneStepItem(addCardStepItem)
                                }
                                
                            }
                            if addCardStep.enabledCloneButton(addCardStepItem: item.wrappedValue) {
                                
                                Button(action: {
                                    addCardStep.cloneStepItem(item.wrappedValue)
                                }, label: {
                                    HStack{
                                        Text("Add".localized())
                                        Image(systemName: "plus.circle")
                                    }
                                })
                                    .padding(EdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 12))
                                    .background(Color.green)
                                    .font(.caption)
                                    .cornerRadius(.infinity)
                                    .foregroundColor(Color.white)
                            }
                            
                        }.buttonStyle(PlainButtonStyle())
                            .padding(12)
//                        HStack{
//                            Color.white
//                                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
//                        }.onTapGesture {
//                            hideKeyboard()
//                        }
                    }
            }
        }
    }
    init(addCardStep: Binding<AddCardStep>, scanTrigger: PassthroughSubject<AddCardStepItem,Error>){
        self._addCardStep = addCardStep
        self._editableCardStep = State(initialValue: addCardStep.wrappedValue)
        self.scanTrigger = scanTrigger
    }
}
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct StepView_Previews: PreviewProvider {
    @State static var cardStep  = AddCardStep(id: 1, items: [])
    static var previews: some View {
        StepView(addCardStep: $cardStep, scanTrigger: PassthroughSubject<AddCardStepItem, Error>())
    }
}
