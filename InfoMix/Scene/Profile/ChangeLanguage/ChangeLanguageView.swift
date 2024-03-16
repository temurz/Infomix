//
//  ChangeLanguageView.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 19/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine

struct ChangeLanguageView: View {
    
    @ObservedObject var output: ChangeLanguageViewModel.Output
    let selectTrigger = PassthroughSubject<IndexPath, Never>()
    let cancelBag = CancelBag()
    var body: some View {
        List{
            ForEach(output.languages.enumerated().map{ $0 }, id: \.element.locale){ index, language in
                Button {
                    selectTrigger.send(IndexPath(row: index, section: 0))
                } label: {
                    LanguageRow(language: language, selectedLanguageCode: $output.selectedLanguageCode)
                }
            }
        }.navigationTitle("Change language".localized())
    }
    
    init(viewModel: ChangeLanguageViewModel){
        let input = ChangeLanguageViewModel.Input(selectLanguageTrigger: self.selectTrigger.asDriver())
        
        self.output = viewModel.transform(input, cancelBag: cancelBag)
    }
}

struct ChangeLanguageView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeLanguageView(viewModel: PreviewAssembler().resolve(navigationController: UINavigationController()))
    }
}

struct LanguageRow: View {
    var language: LanguageSelector
    @Binding var selectedLanguageCode: String

    var body: some View {
        HStack {
           
            Text(language.localizedName)
            Spacer()
            if self.selectedLanguageCode == language.locale {
                Image(systemName: "checkmark")
                    .foregroundColor(.blue)
            }
        }.padding()
    }
}
