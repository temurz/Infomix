//
//  ScannerView.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 15/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine

struct ScannerView: View {
    @ObservedObject var output: ScannerViewModel.Output
    
    let foundQrCodeTrigger = PassthroughSubject<String, Never>()
    let torchToggleTrigger = PassthroughSubject<Void, Never>()
    let scanInterval: Double
    let cancelBag = CancelBag()
    
    var body: some View {
        ZStack {
            
            QrCodeScannerView()
                .found{ r in
                    foundQrCodeTrigger.send(r)
                }
            .torchLight(isOn: self.output.torchIsOn)
            .interval(delay: self.scanInterval)
            
            Text("Scanner goes here...".localized())
                 
            
                 
                 VStack {
                     VStack {
                         Text("Serial number:".localized())
                             .font(.subheadline)
                         Text(self.output.lastQrCode)
                             .bold()
                             .lineLimit(5)
                             .padding()
                     }
                     .padding(.vertical, 20)
                     
                     Spacer()
                     HStack {
                         Button(action: {
                             self.torchToggleTrigger.send()
                         }, label: {
                             Image(systemName: self.output.torchIsOn ? "bolt.fill" : "bolt.slash.fill")
                                 .imageScale(.large)
                                 .foregroundColor(self.output.torchIsOn ? Color.yellow : Color.blue)
                                 .padding()
                         })
                     }
                     .background(Color.white)
                     .cornerRadius(10)
                     
                 }.padding()
             }
    }
    
    init(viewModel: ScannerViewModel){
        self.output = viewModel.transform(ScannerViewModel.Input(foundQrCodeTrigger: self.foundQrCodeTrigger.asDriver(), torchToggleTrigger: self.torchToggleTrigger.asDriver()), cancelBag: self.cancelBag)
        
        self.scanInterval = viewModel.scanInterval
    }
}

struct ScannerView_Previews: PreviewProvider {
    static var previews: some View {
        let assembler = PreviewAssembler()
        return ScannerView(viewModel: assembler.resolve(navigationController: UINavigationController(), onFound: { code in
            
        }))
    }
}
	
