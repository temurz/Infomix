//
//  ICUAssembler.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 14/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import UIKit

protocol ICUAssembler {
    func resolve() -> ICUViewModel
    func resolve() -> ICUView
    func resolve() -> AgentCurrentICUUseCaseType
}

extension ICUAssembler {
    
    
    func resolve() -> ICUViewModel {
      return ICUViewModel(agentCurrentICUUseCase: resolve())
    }
    
    func resolve() -> ICUView {
        return ICUView(viewModel: resolve())
    }
 
    
}
extension ICUAssembler where Self: DefaultAssembler {

    func resolve() -> AgentCurrentICUUseCaseType{
        return AgentCurrentICUUseCase(agentGateway: resolve())
    }
}

extension ICUAssembler where Self: PreviewAssembler {
  
    
    func resolve() -> AgentCurrentICUUseCaseType{
        return AgentCurrentICUUseCase(agentGateway: resolve())
    }
  
}

