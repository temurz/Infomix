//
//  TextFieldContainer.swift
//  InfoMix
//
//  Created by Temur on 19/05/2025.
//  Copyright © 2025 InfoMix. All rights reserved.
//


import Foundation
import SwiftUI
import UIKit

struct TextFieldContainer: UIViewRepresentable {
    private var placeholder : String
    private var text : Binding<String>

    init(_ placeholder:String, text:Binding<String>) {
        self.placeholder = placeholder
        self.text = text
    }

    func makeCoordinator() -> TextFieldContainer.Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: UIViewRepresentableContext<TextFieldContainer>) -> UITextField {

        let innertTextField = UITextField(frame: .zero)
        innertTextField.placeholder = placeholder
        innertTextField.text = text.wrappedValue
        innertTextField.delegate = context.coordinator
        innertTextField.keyboardType = .numberPad

        context.coordinator.setup(innertTextField)

        return innertTextField
    }

    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<TextFieldContainer>) {
        uiView.text = self.text.wrappedValue
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: TextFieldContainer

        init(_ textFieldContainer: TextFieldContainer) {
            self.parent = textFieldContainer
        }

        func setup(_ textField:UITextField) {
            textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        }

        @objc func textFieldDidChange(_ textField: UITextField) {
            self.parent.text.wrappedValue = textField.text ?? ""

            let newPosition = textField.endOfDocument
            textField.selectedTextRange = textField.textRange(from: newPosition, to: newPosition)
        }
    }
}


struct NumberPhoneMaskView: View {
    
    let maskPhone = "+998(__) ___-__-__"
    @Binding var number: String
    
    var body: some View {
        VStack {
            let textChangedBinding = Binding<String>(
                get: {
                    number.formatNumber(mask: maskPhone)
                },
                
                set: { self.number = $0
            })
            TextFieldContainer("+998 (__) ___-__-__", text: textChangedBinding)
        }.padding()
    }
}

struct MaskedTextField: View {
    let mask: String
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        VStack {
            let textChangedBinding = Binding<String>(
                get: {
                    text.formatNumber(mask: mask)
                },
                set: { self.text = $0 })
            TextFieldContainer(placeholder, text: textChangedBinding)
        }
    }
}

#Preview {
    MaskedTextField(mask: "", placeholder: "", text: .constant("123"))
}
