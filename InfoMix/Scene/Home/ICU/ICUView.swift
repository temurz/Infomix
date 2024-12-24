//
//  ICUView.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 14/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine

struct ICUView: View {
    @ObservedObject var output: ICUViewModel.Output
    private let cancelBag = CancelBag()
    private let loadTrigger = PassthroughSubject<Void, Never>()
    private let reloadTrigger = PassthroughSubject<Void, Never>()
    var body: some View {
        HStack(spacing: 10){
            if output.isLoading || output.isReloading {
                ProgressView()
                Text("Loading...".localized())
                    .foregroundStyle(.white)
            } else if output.alert.isShowing{
                Text("Error".localized())
                    .foregroundColor(.red)
                Button(action: {
                    self.loadTrigger.send()
                }){
                    Image(systemName: "goforward")
                        .resizable()
                        .foregroundColor(.white)
                }.frame(width: 18, height: 18)
                    
            }else{
                Text(String(format: "%.2f ball".localized(), output.icu))
                    .font(.title)
                    .bold()
                    .foregroundStyle(.white)
                Button(action: {
                    self.loadTrigger.send()
                }){
                    Image(systemName: "goforward")
                        .resizable()
                        .foregroundColor(.white)
                }.frame(width: 18, height: 18)
            }
        }.onAppear {
            self.loadTrigger.send()
        }
    }
    
    init(viewModel: ICUViewModel){
        let input = ICUViewModel.Input(loadTrigger: loadTrigger.asDriver(), reloadTrigger: reloadTrigger.asDriver())
        
        self.output = viewModel.transform(input, cancelBag: self.cancelBag)
    }
 
}

struct ICUView_Previews: PreviewProvider {
    static var previews: some View {
        let vm :ICUViewModel = PreviewAssembler().resolve()
        ICUView(viewModel: vm)
    }
}
