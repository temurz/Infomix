//
//  OrderHistoryView.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 12/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine

struct OrderHistoryView: View {
    @ObservedObject var output : OrderHistoryViewModel.Output
    
    private let cancelBag = CancelBag()
    
    private let loadOrderStatusTrigger = PassthroughSubject<Void, Never>()
    private let reloadOrdersTrigger = PassthroughSubject<Void, Never>()
    private let selectOrderTrigger = PassthroughSubject<Int, Never>()
    private let loadMoreOrdersTrigger = PassthroughSubject<Void, Never>()
     private let loadOrdersTrigger = PassthroughSubject<Void, Never>()
    
    var body: some View {
        LoadingView(isShowing: $output.isLoading, text: .constant("")){
            ScrollView {
                LazyVStack{
                    ForEach($output.orders){
                        order in
                        Button(action: {
                            self.selectOrderTrigger.send(order.wrappedValue.id)
                        }) {
                            OrderHistoryItemView(order: order)
                        } .onAppear {
                            
                            if output.orders.last?.id ?? -1 == order.wrappedValue.id && output.hasMorePages { // 6
                                self.loadMoreOrdersTrigger.send()
                            }
                         }
                        Divider()
                    }
                }
                if output.hasMorePages {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .padding()
                }
            }
            .navigationTitle("My orders".localized())
            .toolbar {
                ToolbarItem(placement: .primaryAction){
                    Menu("Filter".localized()){
                        Picker(selection: $output.selectedStatusValue, label: Text("Select status".localized())) {
                            Text("All".localized()).tag("all")
                            ForEach(output.statuses.indices, id: \.self){index in
                                let status = output.statuses[index]
                                Text(status.text.localized()).tag(status.value)
                            }
                        }.onChange(of: output.selectedStatusValue) { newValue in
                            self.loadOrdersTrigger.send()
                        }
                    }
                }
            }
            .onAppear {
                self.loadOrdersTrigger.send()
            }
        }
        
        .alert(isPresented: $output.alert.isShowing) {
            Alert(
                title: Text(output.alert.title),
                message: Text(output.alert.message),
                dismissButton: .default(Text("OK"))
            )
        }
        
    }
    

    init(viewModel: OrderHistoryViewModel) {
        let input = OrderHistoryViewModel.Input(loadOrderStatusListTrigger: self.loadOrderStatusTrigger.asDriver(), loadOrderListTrigger: self.loadOrdersTrigger.asDriver(), reloadOrderListTrigger: self.reloadOrdersTrigger.asDriver(), loadMoreOrderListTrigger: self.loadMoreOrdersTrigger.asDriver(), selectOrderTrigger: self.selectOrderTrigger.asDriver())
        
        self.output = viewModel.transform(input, cancelBag: cancelBag)
        self.loadOrderStatusTrigger.send()
    }
}

struct OrderHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        OrderHistoryView(viewModel: PreviewAssembler().resolve(navigationController: UINavigationController()))
    }
}
