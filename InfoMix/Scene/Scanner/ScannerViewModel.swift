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
    let scanViewUseCase: ScannerViewUseCaseType
    let onFound: (_ product: SerialNumberedProduct?) -> Void
    /// Defines how often we are going to try looking for a new QR-code in the camera feed.
    let scanInterval: Double = 1.0
}

extension ScannerViewModel: ViewModel{
   
    
    struct Input{
        let foundQrCodeTrigger: Driver<String>
        let torchToggleTrigger: Driver<Void>
        let popViewTrigger: Driver<Void>
    }
    
    final class Output: ObservableObject{
        @Published var torchIsOn: Bool = false
        @Published var lastQrCode: String = ""
        @Published var showBottomSheet = false
        @Published var isLoading = false
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let errorTracker = ErrorTracker()
        let activityTracker = ActivityTracker(false)
        let output = Output()
        input.foundQrCodeTrigger.handleEvents(receiveOutput: {
            code in
            output.lastQrCode = code
            
            scanViewUseCase.checkSerialNumber(code)
                .trackError(errorTracker)
                .trackActivity(activityTracker)
                .asDriver()
                .sink { product in
                    onFound(product)
                    navigationController.topViewController?.dismiss(animated: true)
                }
                .store(in: cancelBag)
            
        }).sink().store(in: cancelBag)
        
        input.torchToggleTrigger.handleEvents(receiveOutput: {
            output.torchIsOn.toggle()
        }).sink().store(in: cancelBag)


        input.popViewTrigger
            .sink {
                navigationController.topViewController?.dismiss(animated: true)
                onFound(nil)
            }
            .store(in: cancelBag)
        
        activityTracker
            .receive(on: RunLoop.main)
            .assign(to: \.isLoading, on: output)
            .store(in: cancelBag)

        return output
    }
}
