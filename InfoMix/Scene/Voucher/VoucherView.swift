//
//  VoucherView.swift
//  InfoMix
//
//  Created by Temur on 13/06/2025.
//  Copyright © 2025 InfoMix. All rights reserved.
//

import SwiftUI
import Localize_Swift
import Combine

struct VoucherView: View {
    @ObservedObject var output: VoucherViewModel.Output
    private let cancelBag = CancelBag()
    
    private let backButtonTrigger = PassthroughSubject<Void, Never>()
    private let filterTrigger = PassthroughSubject<Void, Never>()
    private let onAppearTrigger = PassthroughSubject<Void, Never>()
    private let selectStatusTrigger = PassthroughSubject<String, Never>()
    
    var body: some View {
        return LoadingView(isShowing: $output.isLoading, text: .constant("")) {
            VStack {
                CustomNavigationBar(title: "Get balls".localized(), rightBarTitle: "Filter".localized()) {
                    backButtonTrigger.send(())
                } onRightBarButtonTapAction: {
                    
                }
                Text("Reminder".localized())
                Spacer()
            }
        }
        .onAppear {
            onAppearTrigger.send(())
            selectStatusTrigger.send("")
        }
        
    }
    
    init(viewModel: VoucherViewModel) {
        let input = VoucherViewModel.Input(
            popViewTrigger: backButtonTrigger.asDriver(),
            onAppearTrigger: onAppearTrigger.asDriver(),
            selectStatus: selectStatusTrigger.asDriver()
        )
        self.output = viewModel.transform(input, cancelBag: cancelBag)
    }
}
