//
//  MyCardsView.swift
//  InfoMix
//
//  Created by Temur on 24/01/22.
//  Copyright © 2022 InfoMix. All rights reserved.
//

import SwiftUI
import Combine

struct MyCardsView: View {
    
    @ObservedObject var output: MyCardsViewModel.Output
    private let cancelBag = CancelBag()
    private let reloadCardsHistoryTrigger = PassthroughSubject<Void, Never>()
    private let loadMoreCardsHistoryTrigger = PassthroughSubject<Void,Never>()
    private let loadCardsHistoryTrigger = PassthroughSubject<Void,Never>()
    private let showDatePickerTrigger = PassthroughSubject<Void,Never>()
    private let popViewTrigger = PassthroughSubject<Void,Never>()
    private let selectCardRowTrigger = PassthroughSubject<IndexPath,Never>()
    var body: some View {
        
        return LoadingView(isShowing: $output.isLoading, text: .constant("")) {
            VStack {
                CustomNavigationBar(title: "My cards".localized(), rightBarTitle: "Filter".localized()) {
                    popViewTrigger.send(())
                } onRightBarButtonTapAction: {
                    self.showDatePickerTrigger.send()
                }
                LazyVStack {
                    ForEach(output.serialCards.enumerated().map{ $0}, id: \.element.id){index, card in

                        Button {
                            self.selectCardRowTrigger.send(IndexPath(row: index, section: 0))
                        } label: {
                            MyCardsRow(viewModel: card)
                        }
                    }


                }
            }

        }
        .bottomSheet(bottomSheetPosition: $output.bottomSheetPosition, options: [.swipeToDismiss, .tapToDissmiss, .noBottomPosition, .background(AnyView(Color.white)), .backgroundBlur(effect: .dark)],
                     headerContent:{
            HStack(){
                Image(systemName: "calendar")
                    .resizable()
                    .frame(width: 24, height: 24)
                Text("Filter".localized())
                    .padding()
                
                Spacer()
                
                Button(action: {
                    withAnimation(.easeOut(duration: 0.2)) {
                        output.bottomSheetPosition = .hidden
                    }
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.gray)
                        .frame(width: 24, height: 24)
                    
                }
            }
            .padding()
        }) {
            
            Divider()
            MyCardsDatePicker(from: output.from, to: output.to) {from, to in
                output.from = from
                output.to = to
                withAnimation(.easeOut(duration: 0.2)) {
                    output.bottomSheetPosition = .hidden
                }
                self.loadCardsHistoryTrigger.send()
//                self.loadTransactionHistoryTrigger.send()
//                self.loadTransactionStatisticTrigger.send()
            }
        }
    }
    
    
    init(viewModel: MyCardsViewModel){
        let input = MyCardsViewModel.Input(
            loadCardsHistoryTrigger: self.loadCardsHistoryTrigger.asDriver(),
            reloadCardsHistoryTrigger: self.reloadCardsHistoryTrigger.asDriver(),
            loadMoreCardsHistorytrigger: self.loadMoreCardsHistoryTrigger.asDriver(),
            showDatePickerTrigger: self.showDatePickerTrigger.asDriver(),
            selectCardRowTrigger: self.selectCardRowTrigger.asDriver(),
            popViewTrigger: popViewTrigger.asDriver()
        )

        self.output = viewModel.transform(input, cancelBag: cancelBag)
    }
}

struct MyCardsView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel : MyCardsViewModel = PreviewAssembler().resolve(navigationController: UINavigationController())
        MyCardsView(viewModel: viewModel)
    }
}
