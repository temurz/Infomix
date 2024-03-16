//
//  MutableCardConfig.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 22/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

class MutableCardConfig {
    let wrappedValue: CardConfig
    
    init(value: CardConfig) {
        self.wrappedValue  = value
    }
    
}
