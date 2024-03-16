//
//  ConfirmViewModel.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 23/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//


import Combine
import SwiftUI

struct AddCardConfirmViewModel {
    let cardConfig: CardConfig
}

extension AddCardConfirmViewModel : ViewModel {
    
    struct Input{
        let sendCardTrigger: Driver<Void>
        let prevStepTrigger: Driver<Void>
    }
    
    final class Output: ObservableObject {
        @Published var cardConfig: CardConfig
        @Published var currentCardStep: AddCardStep = AddCardStep.none()
        @Published var certificate: CertificateItemViewModel = CertificateItemViewModel()
        @Published var hasNextStep: Bool = false
        @Published var hasPrevStep: Bool = false
        @Published var enabledSendButton: Bool = false
        @Published var alert: AlertMessage = AlertMessage()
        @Published var isLoading: Bool = false
        
        init(cardConfig: CardConfig) {
            self.cardConfig = cardConfig
        }
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output(cardConfig: self.cardConfig)
        
        input.prevStepTrigger.handleEvents(receiveOutput: {
            
            output.cardConfig.update(cardStep: output.currentCardStep)
            
            let currentStepIndex = output.cardConfig.indexStep(of: output.currentCardStep)
            
            if let prevStepIndex = output.currentCardStep.isConfirmation() ? output.cardConfig.endIndex() - 1 :  output.cardConfig.prevIndex(currentIndex: currentStepIndex) {
                output.hasNextStep = output.cardConfig.nextIndex(currentIndex: prevStepIndex) != nil || output.cardConfig.showConfirmation
                output.enabledSendButton = !output.hasNextStep
                output.hasPrevStep = output.cardConfig.prevIndex(currentIndex: prevStepIndex) != nil
                output.currentCardStep = output.cardConfig.getStep(currentIndex: prevStepIndex)
            } else {
                output.alert = AlertMessage.init(title: "Error", message:
                                                    "Step not found", isShowing: true)
            }
            
            
        }).sink()
            .store(in: cancelBag)
        
        
        return output
    }
    
}
