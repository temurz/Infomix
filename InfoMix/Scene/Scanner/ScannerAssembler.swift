//
//  ScannerAssembler.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 05/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//



import UIKit

protocol ScannerAssembler {
    func resolve(navigationController: UINavigationController, onFound: @escaping (_ code: SerialNumberedProduct) -> Void) -> ScannerView
    func resolve(navigationController: UINavigationController, useCase: ScannerViewUseCaseType, onFound: @escaping (_ code: SerialNumberedProduct) -> Void) -> ScannerViewModel
    func resolve() -> ScannerViewUseCaseType
}

extension ScannerAssembler {
    func resolve(navigationController: UINavigationController, onFound: @escaping (_ code: SerialNumberedProduct) -> Void) -> ScannerView {
        return ScannerView(viewModel: resolve(navigationController: navigationController, useCase: resolve(), onFound: onFound))
    }
    
    func resolve(navigationController: UINavigationController, useCase: ScannerViewUseCaseType, onFound: @escaping (_ code: SerialNumberedProduct) -> Void) -> ScannerViewModel {
        return ScannerViewModel(navigationController: navigationController, scanViewUseCase: useCase, onFound: onFound)
    }
}

extension ScannerAssembler where Self: DefaultAssembler {
    func resolve() -> ScannerViewUseCaseType {
        return ScannerViewUseCase(checkSerialNumberGateway: CheckSerialNumberGateway())
    }
}

extension ScannerAssembler where Self: PreviewAssembler {
    func resolve() -> ScannerViewUseCaseType {
        return ScannerViewUseCase(checkSerialNumberGateway: CheckSerialNumberGateway())
    }
}

