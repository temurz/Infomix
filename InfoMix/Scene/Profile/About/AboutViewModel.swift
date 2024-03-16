//
//  ShoppingViewModel.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 06/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Combine
import SwiftUI

struct AboutViewModel {
    
}

extension AboutViewModel : ViewModel {
    
    struct Input {
        let callTrigger: Driver<Void>
        let openTelegramTrigger: Driver<Void>
    }
    
    final class Output: ObservableObject {
        
        @Published var phone: String = ""
        @Published var telegram: String? = nil
        @Published var phoneWithoutSpace: String = ""
        
        init(about: About){
            self.phone = about.phone ?? ""
            self.telegram = about.telegramAccount
            self.phoneWithoutSpace = about.phoneWithoutSpace ?? ""
        }
        
        
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        
        
        let output = Output(about: About.airfel())
        

        input.openTelegramTrigger.sink { () in
            if let telegram = output.telegram {
            let telegramUrl = URL.init(string: "tg://\(telegram)")!
            
            let webURL = URL.init(string: "https://t.me/\(telegram)")!

            if UIApplication.shared.canOpenURL(telegramUrl) {
                UIApplication.shared.open(telegramUrl, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.open(webURL, options: [:], completionHandler: nil)
            }
            }
        }.store(in: cancelBag)
        
        
        input.callTrigger.sink { () in
            if let phoneCallURL = URL(string: "tel://\(output.phoneWithoutSpace)") {
                if (UIApplication.shared.canOpenURL(phoneCallURL)) {
                    UIApplication.shared.open(phoneCallURL, options: [:], completionHandler: nil)
              }
            }
        }.store(in: cancelBag)
        
        
        
        return output
    }
    
}
