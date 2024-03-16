//
//  MyCardsViewModel.swift
//  InfoMix
//
//  Created by Temur on 24/01/22.
//  Copyright © 2022 InfoMix. All rights reserved.
//

import Foundation
import SwiftUI

struct MyCardsViewModel{
    let useCase: MyCardsUseCaseType
    let navigator: MyCardsNavigatorType
}

extension MyCardsViewModel : ViewModel {
    
    
    struct Input {
        let loadCardsHistoryTrigger: Driver<Void>
        let reloadCardsHistoryTrigger: Driver<Void>
        let loadMoreCardsHistorytrigger: Driver<Void>
        let showDatePickerTrigger: Driver<Void>
        let selectCardRowTrigger: Driver<IndexPath>
    }
    
    final class Output : ObservableObject {
        @Published var serialCards = [MyCardItemViewModel]()
        @Published var isLoading = false
        @Published var isReloading = false
        @Published var isLoadingMore = false
        @Published var alert = AlertMessage()
        @Published var bottomSheetPosition: BottomSheetPosition1 = .hidden
        @Published var from = Date().startOfMonth
        @Published var to = Date()
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        
        let getPageInput = GetPageInput(loadTrigger: input.loadCardsHistoryTrigger.asDriver(), reloadTrigger: input.reloadCardsHistoryTrigger.asDriver(), loadMoreTrigger: input.loadMoreCardsHistorytrigger.asDriver(), getItems: useCase.getCardsHistory)
        let (page,error,isLoading,isReloading,isLoadingMore) = getPage(input: getPageInput).destructured
        
        page
            .map{$0.items.map(MyCardItemViewModel.init)}
            .assign(to: \.serialCards, on: output)
            .store(in: cancelBag)
        
        error
            .receive(on: RunLoop.main)
            .map { AlertMessage(error: $0) }
            .assign(to: \.alert, on: output)
            .store(in: cancelBag)
            
        isLoading
            .assign(to: \.isLoading, on: output)
            .store(in: cancelBag)
        
        isReloading
            .assign(to: \.isReloading, on: output)
            .store(in: cancelBag)
        
        isLoadingMore
            .assign(to: \.isLoadingMore, on: output)
            .store(in: cancelBag)
        
        input.showDatePickerTrigger.sink{
            withAnimation(.linear) {
                output.bottomSheetPosition = .middle
            }
        }.store(in: cancelBag)
        
        input.selectCardRowTrigger.sink { indexPath in
            let serialCard = output.serialCards[indexPath.row].serialCard
            self.navigator.toCardDetail(card: serialCard)
        }.store(in: cancelBag)
        
        return output
    }
}
