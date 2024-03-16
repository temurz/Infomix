//
//  HomeAttachedView.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 14/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import SwiftUI

protocol HomeAttachedViewType{
    func getICUView() -> ICUView
}

struct HomeAttachedView: HomeAttachedViewType {
    
    func getICUView() -> ICUView {
        let vm: ICUViewModel = assembler.resolve()
        
        return ICUView(viewModel: vm)
    }
    

    unowned let assembler: Assembler
}

