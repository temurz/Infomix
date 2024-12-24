//
//  MyCardsDetailViewModel.swift
//  InfoMix
//
//  Created by Temur on 26/01/22.
//  Copyright © 2022 InfoMix. All rights reserved.
//

import Foundation

struct MyCardsDetailViewModel {
    let useCase: MyCardsDetailUseCaseType
    let serialCard: SerialCard
}

extension MyCardsDetailViewModel: ViewModel{
    
    struct Input{
        let loadTrigger: Driver<Int>
        let popViewTrigger: Driver<Void>
    }
    
    final class Output: ObservableObject{
        @Published var serialCard: SerialCard
        @Published var isLoading = false
        @Published var alert = AlertMessage()
        
        init(serialCard: SerialCard){
            self.serialCard = serialCard
        }
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output(serialCard: self.serialCard)
        
        let getItemInput = GetItemInput(loadTrigger: input.loadTrigger, reloadTrigger: Driver.empty(), getItem: self.useCase.getCardDetail)
        let (card,error, isLoading, _) = getItem(input: getItemInput).destructured
        
        card
            .assign(to: \.serialCard, on: output)
            .store(in: cancelBag)
        
        error
            .receive(on: RunLoop.main)
            .map { AlertMessage(error: $0) }
            .assign(to: \.alert, on: output)
            .store(in: cancelBag)
        
        isLoading
            .assign(to: \.isLoading, on: output)
            .store(in: cancelBag)
        
        return output
    }
    
    
}
