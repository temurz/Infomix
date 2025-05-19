//
//  TextFieldWithValidation.swift
//  InfoMix
//
//  Created by Temur on 19/05/2025.
//  Copyright © 2025 InfoMix. All rights reserved.
//

import SwiftUI

struct TextFieldWithValidation: View {
    @Binding var inputText: String
    var placeholder: String
    var validationMessage: String
    var keyboardType: UIKeyboardType = .default
    var body: some View {
        VStack(alignment: .leading) {
            TextField(placeholder, text: $inputText)
                .keyboardType(keyboardType)
                .padding()
                .frame(height: 44)
                .background(lightGreyColor)
                .cornerRadius(12)
            Text(validationMessage)
                .foregroundColor(.red)
                .font(.footnote)
                .lineLimit(nil)
        }
    }
}
