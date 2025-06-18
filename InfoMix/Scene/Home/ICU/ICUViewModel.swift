//
//  ICUViewModel.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 14/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//


import Combine
import Alamofire
import Foundation

struct ICUViewModel {
    let agentCurrentICUUseCase: AgentCurrentICUUseCaseType
}

extension ICUViewModel: ViewModel {
    
    struct Input{
        let loadTrigger: Driver<Void>
        let reloadTrigger: Driver<Void>
    }

    final class Output: ObservableObject {
       
        @Published var icu: Double = 0.0
        @Published var isLoading: Bool = false
        @Published var isReloading: Bool = false
        @Published var alert: AlertMessage  = AlertMessage()
        
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
       let output = Output()
        
        let getItemInput = GetItemInput(loadTrigger: input.loadTrigger,
                                        reloadTrigger: input.reloadTrigger,
                                        getItem: agentCurrentICUUseCase.getAgentCurrentICU)
        let (item, error, isLoading, isReloading) = getItem(input: getItemInput).destructured

        item
            .map {
                UserDefaults.standard.setValue($0.balance, forKey: "balance")
                return $0.balance
            }
            .assign(to: \.icu, on: output)
            .store(in: cancelBag)
       
        isLoading.assign(to: \.isLoading, on: output)
            .store(in: cancelBag)
        
         isReloading.assign(to: \.isReloading, on: output)
             .store(in: cancelBag)

        error.map{ AlertMessage.init(error: $0) }
            .assign(to: \.alert, on: output)
            .store(in: cancelBag)
        
        return output
    }
}

