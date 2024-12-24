//
//  StatusViewModel.swift
//  InfoMix
//
//  Created by Temur on 16/12/2024.
//  Copyright © 2024 InfoMix. All rights reserved.
//
import Combine
struct StatusViewModel {
    let navigator: StatusViewNavigatorType
}

extension StatusViewModel: ViewModel {
    struct Input {
        
    }
    
    final class Output: ObservableObject {
        
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        
        return output
    }
}
