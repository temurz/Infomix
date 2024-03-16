//
//  AddCardViewModel.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 22/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//
import Combine
import SwiftUI

struct AddCardViewModel {
    let cardConfig: CardConfig
    let navigator: AddCardNavigatorType
}

extension AddCardViewModel : ViewModel {
    
    struct Input{
        let nextStepTrigger: Driver<Void>
        let prevStepTrigger: Driver<Void>
        let sendCardTrigger: Driver<Void>
        let scanTrigger: Driver<AddCardStepItem>
    }
    
    final class Output: ObservableObject {
        @Published var cardConfig: CardConfig
        @Published var currentCardStep: AddCardStep = AddCardStep.none()
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
        
        
        
        input.nextStepTrigger.sink{
            _ in
            
            output.cardConfig.update(cardStep: output.currentCardStep)
            
            let currentStepIndex = output.cardConfig.indexStep(of: output.currentCardStep)
            
            if let nextStepIndex = output.currentCardStep.isNone() ? output.cardConfig.startIndex() :  output.cardConfig.nextIndex(currentIndex: currentStepIndex){
                output.hasNextStep = output.cardConfig.nextIndex(currentIndex: nextStepIndex) != nil
                output.enabledSendButton = !output.hasNextStep
                output.hasPrevStep = output.cardConfig.prevIndex(currentIndex: nextStepIndex) != nil
                output.currentCardStep = output.cardConfig.getStep(currentIndex: nextStepIndex)
            } 
            
            
        }
        .store(in: cancelBag)
        
        
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
        
        input.sendCardTrigger.handleEvents(receiveOutput: {
            output.cardConfig.update(cardStep: output.currentCardStep)
            self.navigator.showSendingTimeline(cardConfig: output.cardConfig)
        }).sink()
            .store(in: cancelBag)
        
        input.scanTrigger.handleEvents(receiveOutput: { item in
            self.navigator.showScanner { code in
                if let stepItemIndex = output.currentCardStep.items.firstIndex(of: item){
                    var stepItem = output.currentCardStep.items[stepItemIndex]
                    stepItem.valueString = code
                    output.currentCardStep.items[stepItemIndex] = stepItem
                    
                    output.cardConfig.update(cardStep: output.currentCardStep)
                    
                    let currentStepIndex = output.cardConfig.indexStep(of: output.currentCardStep)
                    
                    if let nextStepIndex = output.currentCardStep.isNone() ? output.cardConfig.startIndex() :  output.cardConfig.nextIndex(currentIndex: currentStepIndex){
                        output.hasNextStep = output.cardConfig.nextIndex(currentIndex: nextStepIndex) != nil
                        output.enabledSendButton = !output.hasNextStep
                        output.hasPrevStep = output.cardConfig.prevIndex(currentIndex: nextStepIndex) != nil
                        output.currentCardStep = output.cardConfig.getStep(currentIndex: nextStepIndex)
                    }
                }
                
                
            }
        }).sink()
            .store(in: cancelBag)
        
        
        return output
    }
    
}
