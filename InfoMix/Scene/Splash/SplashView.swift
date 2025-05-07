//
//  SplashView.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 10/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine
import UIKit

struct SplashView: View {
    
    @ObservedObject var output: SplashViewModel.Output
    
    private let cancelBag = CancelBag()
    private let startTrigger = PassthroughSubject<Void, Never>()
    private let loadTrigger = PassthroughSubject<CardConfigInput, Never>()
    var body: some View {
        VStack{
            if output.isLoading {
                Text("Loading...".localized())
            } else {
                Image("logo")
                   .resizable()
                   .scaledToFit()
                   .frame(width: 220, height: 220)
//                   .onAppear {
//                    self.startTrigger.send()
//                }
            }
           
        } .alert(isPresented: $output.alert.isShowing) {
            Alert(
                title: Text(output.alert.title),
                message: Text(output.alert.message),
                dismissButton: .default(Text("OK"))
            )
        }
        .onAppear {
            if let configCode = UserDefaults.standard.string(forKey: "configCode"),
               let _ = UserDefaults.standard.string(forKey: "token") {
                let configVersion = UserDefaults.standard.string(forKey: "configVersion")
                loadTrigger.send(CardConfigInput(configCode: configCode, configVersion: configVersion))
            } else {
                startTrigger.send(())
            }
        }
        
    }
    
    
    init(viewModel: SplashViewModel) {
        let input = SplashViewModel.Input(
            startTrigger:  startTrigger.asDriver(),
            loadTrigger: loadTrigger.asDriver()
        )
        
        self.output = viewModel.transform(input, cancelBag: cancelBag)
        
    }
}
