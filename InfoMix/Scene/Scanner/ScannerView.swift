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
    let popViewTrigger = PassthroughSubject<Void, Never>()
    let scanInterval: Double
    let cancelBag = CancelBag()
    let focusedAreaWidth = UIScreen.screenWidth - 64
    let focusedAreaHeight = UIScreen.screenWidth / 2
    
    
    var body: some View {
        return LoadingView(isShowing: $output.isLoading, text: .constant("")) {
            ZStack {
                
                QrCodeScannerView()
                    .found{ r in
                        foundQrCodeTrigger.send(r)
                    }
                    .interval(delay: self.scanInterval)
                    .ignoresSafeArea(.all)
                Color.black.opacity(0.6)
                    .mask(
                        HoleShapeMask(rect: CGRect(
                            x: (UIScreen.screenWidth - focusedAreaWidth) / 2,
                            y: (UIScreen.screenHeight - focusedAreaHeight) / 2,
                            width: focusedAreaWidth,
                            height: focusedAreaHeight
                        ))
                        .fill(style: FillStyle(eoFill: true))
                        .compositingGroup()
                    )
                    .ignoresSafeArea(.all)
                
                VStack {
                    HStack {
                        Button {
                            popViewTrigger.send(())
                        } label: {
                            Image(systemName: "chevron.left")
                                .resizable()
                                .foregroundStyle(Colors.appMainColor)
                                .aspectRatio(contentMode: .fit)
                                .padding(2)
                        }
                        .frame(width: 24, height: 24)
                        .padding(.leading)
                        Spacer()
                    }
                    .background(.clear)
                    Spacer()
                }
                .padding()
                
                
                VStack {
                    VStack {
                        Text("Ichki blok seriya raqami")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding(.top, 16)
                    }
                    .padding(.vertical, 20)
                    
                    Spacer()
                    Button(action: {
                        output.showBottomSheet = true
                    }) {
                        Text("Qo'l bilan kiriting")
                            .foregroundColor(.white)
                            .bold()
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(25)
                            .padding(.horizontal)
                    }
                }.padding()
                BottomSheetView(isShowing: $output.showBottomSheet) {
                    VStack {
                        HStack {
                            Spacer()
                            Button {
                                output.showBottomSheet = false
                            } label: {
                                Image(systemName: "minus.circle")
                                    .centerCropped()
                                    .foregroundStyle(.white)
                                    .frame(width: 24, height: 24)
                            }
                        }
                        Text("Serial nomer orqali yuborish")
                            .foregroundStyle(Color.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        TextField("Serial number", text: $output.lastQrCode)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(25)
                            .foregroundColor(.black)
                        HStack {
                            Spacer()
                            Button {
                                foundQrCodeTrigger.send(output.lastQrCode)
                            } label: {
                                Text("Send".localized())
                                    .foregroundStyle(Colors.appMainColor)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 4)
                                    .background(.white)
                                    .clipShape(Capsule())
                            }
                        }
                        
                    }
                    .padding()
                    .background(Colors.appMainColor)
                    .cornerRadius(radius: 12, corners: [.topLeft, .topRight])
                    .ignoresSafeArea()
                }
                .ignoresSafeArea()
            }
        }
    }
    
    init(viewModel: ScannerViewModel){
        self.output = viewModel.transform(ScannerViewModel.Input(foundQrCodeTrigger: self.foundQrCodeTrigger.asDriver(), torchToggleTrigger: self.torchToggleTrigger.asDriver(), popViewTrigger: popViewTrigger.asDriver()), cancelBag: self.cancelBag)
        
        self.scanInterval = viewModel.scanInterval
    }
}

struct ScannerView_Previews: PreviewProvider {
    static var previews: some View {
        let assembler = PreviewAssembler()
        return ScannerView(viewModel: assembler.resolve(navigationController: UINavigationController(), useCase: assembler.resolve(), onFound: { code in
            
        }))
    }
}

struct HoleShapeMask: Shape {
    let rect: CGRect
    
    func path(in frame: CGRect) -> Path {
        var path = Path()
        
        // Outer full-screen rectangle
        path.addRect(frame)
        
        // Inner hole (transparent area)
        path.addRect(rect)
        
        return path
    }
}
