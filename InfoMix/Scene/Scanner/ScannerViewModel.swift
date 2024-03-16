//
//  ScannerViewModel.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 15/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import Foundation
import UIKit
import Combine

struct ScannerViewModel{
    
    
    let navigationController: UINavigationController
    let onFound: (_ code: String)->Void
    /// Defines how often we are going to try looking for a new QR-code in the camera feed.
    let scanInterval: Double = 1.0
}

extension ScannerViewModel: ViewModel{
   
    
    struct Input{
        let foundQrCodeTrigger: Driver<String>
        let torchToggleTrigger: Driver<Void>
    }
    
    final class Output: ObservableObject{
        
        @Published var torchIsOn: Bool = false
        @Published var lastQrCode: String = ""
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        input.foundQrCodeTrigger.handleEvents(receiveOutput: {
            code in
            output.lastQrCode = code
            onFound(code)
            navigationController.popViewController(animated: true)
        }).sink().store(in: cancelBag)
        
        input.torchToggleTrigger.handleEvents(receiveOutput: {
            output.torchIsOn.toggle()
        }).sink().store(in: cancelBag)
        
        
        return output
    }
}
