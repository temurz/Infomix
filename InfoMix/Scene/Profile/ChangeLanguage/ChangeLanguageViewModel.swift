//
//  ChangeLanguageViewModel.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 19/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Combine
import SwiftUI
import Localize_Swift

struct ChangeLanguageViewModel {
    let navigator: ChangeLanguageNavigatorType
    let languages = [LanguageSelector(locale: "ru", localizedName: "Русский"), LanguageSelector(locale: "uz", localizedName: "O'zbekcha")]
}

extension ChangeLanguageViewModel : ViewModel {
    
    struct Input {
        
        let selectLanguageTrigger: Driver<IndexPath>
        let popViewTrigger: Driver<Void>

    }
    
    final class Output: ObservableObject {
       
        @Published var languages = [LanguageSelector]()
        @Published var selectedLanguageCode = ""
        
        
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        
        let output = Output()
        
        output.languages = self.languages
        
        output.selectedLanguageCode = Localize.currentLanguage()
        
        input.selectLanguageTrigger.handleEvents ( receiveOutput: { it in
            
            
            let newLanguage = output.languages[it.row]
            
            output.selectedLanguageCode = newLanguage.locale
            
            Localize.setCurrentLanguage(output.selectedLanguageCode)
            
        }).sink().store(in: cancelBag)
        
        input.popViewTrigger
            .sink {
                navigator.back()
            }
            .store(in: cancelBag)

        return output
    }
    
}

