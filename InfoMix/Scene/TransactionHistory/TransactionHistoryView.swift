//
//  HistoryView.swift
//  CleanArchitecture
//
//  Created by Temur on 08/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine

struct TransactionHistoryView: View {
    
    @State private var showingAlert = false
    @ObservedObject var output : TransactionHistoryViewModel.Output
    private let cancelBag = CancelBag()
    private let loadTransactionHistoryTrigger = PassthroughSubject<Void, Never>()
    private let reloadTransactionHistoryTrigger = PassthroughSubject<Void, Never>()
    private let loadMoreTransactionHistoryTrigger = PassthroughSubject<Void,Never>()
    private let selectCalendarTrigger = PassthroughSubject<Void,Never>()
    private let loadTransactionTypesListTrigger = PassthroughSubject<Void,Never>()
    private let loadTransactionStatisticTrigger = PassthroughSubject<Void,Never>()
    
    var body: some View {
        return LoadingView(isShowing: $output.isLoading, text: .constant("")) {
            ScrollView{
                LazyVStack{
                    HStack{
                        HStack{
                            Spacer().frame(width: 10)
                            Image(systemName: "arrow.down.circle")
                                .resizable()
                                .foregroundColor(.green)
                                .frame(width: 25, height: 25)
                            VStack{
                                Text("Coming".localized())
                                    .foregroundColor(Color.gray)
                                Text("+" + String(format: "%.0f", output.transactionStatistic.coming! ) + " ball".localized())
                                    .foregroundColor(Color.green)
                            }
                            Spacer()
                        }
                        .padding(.init(top: 8, leading: 0, bottom: 8, trailing: 0))
                        
                        HStack{
                            Spacer().frame(width: 10)
                            Image(systemName: "arrow.up.circle")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .foregroundColor(.red)
                            VStack{
                                Text("Expense".localized())
                                    .foregroundColor(Color.gray)
                                Text("-" + String(format: "%.0f", output.transactionStatistic.expense!) + " ball".localized())
                                    .foregroundColor(Color.red)
                            }
                            Spacer()
                        }
                        .padding(.init(top: 8, leading: 0, bottom: 8, trailing: 0))
                        
                    }
                    HStack{
                        Spacer().frame(width: 5)
                        Button {
                            self.selectCalendarTrigger.send()
                        } label: {
                            HStack{
                                
                                Text("\(output.from.toShortFormat()) - \(output.to.toShortFormat())")
                                Image(systemName: "chevron.compact.down")
                                
                            }.font(.caption2)
                                .foregroundColor(.gray)
                                .padding(6)
                                .background(Color(.secondarySystemBackground))
                                .cornerRadius(10.0)
                        }
                        Menu("Filter".localized()){
                            Picker(selection: $output.type, label: Text("Select type".localized())) {
                                Text("All".localized()).tag("all")
                                ForEach(output.transactionTypes.indices, id: \.self){index in
                                    let type = output.transactionTypes[index]
                                    Text(type.textField.localized()).tag(type.valueField)
                                }
                               
                            }
                        }
                        .onChange(of: output.type) { newValue in
                            self.loadTransactionHistoryTrigger.send()
                        }
                        .font(.caption2)
                        .foregroundColor(.gray)
                        .padding(6)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(10.0)
                        
                        Spacer()
                    }
                    ForEach($output.transactionHistory){transaction in
                        
                        TransactionHistoryRow(transactionRow: transaction)
                            .onAppear {
                                if output.transactionHistory.last?.id ?? -1 == transaction.wrappedValue.id && output.hasMorePages {
                                    self.loadMoreTransactionHistoryTrigger.send()
                                }
                            }
                        Divider()
                    }
                    Spacer()
                    if output.hasMorePages {
                        ProgressView()
                            .progressViewStyle(.circular)
                    }
                    
                    
                    
                }
                .navigationTitle("Transaction History".localized())
                .alert(isPresented: $output.alert.isShowing) {
                    Alert(
                        title: Text(output.alert.title),
                        message: Text(output.alert.message),
                        dismissButton: .default(Text("OK"))
                    )
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
            CalendarAlert(from: output.from, to: output.to) {from, to in
                output.from = from
                output.to = to
                withAnimation(.easeOut(duration: 0.2)) {
                    output.bottomSheetPosition = .hidden
                }
                self.loadTransactionHistoryTrigger.send()
                self.loadTransactionStatisticTrigger.send()
            }
        }
    }
    
    init(viewModel: TransactionHistoryViewModel){
        let input = TransactionHistoryViewModel.Input(loadTransactionHistoryTrigger: self.loadTransactionHistoryTrigger.asDriver(), reloadTransactionHistoryTrigger: self.reloadTransactionHistoryTrigger.asDriver(), loadMoreTransactionHistoryTrigger: self.loadMoreTransactionHistoryTrigger.asDriver(), selectCalendarTrigger: self.selectCalendarTrigger.asDriver(), loadTransactionTypesListTrigger: self.loadTransactionTypesListTrigger.asDriver(), loadTransactionStatisticTrigger: self.loadTransactionStatisticTrigger.asDriver())
        
        self.output = viewModel.transform(input, cancelBag: cancelBag)
        self.loadTransactionTypesListTrigger.send()
        self.loadTransactionHistoryTrigger.send()
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel : TransactionHistoryViewModel = PreviewAssembler().resolve(navigationController: UINavigationController())
        TransactionHistoryView(viewModel: viewModel)
    }
}
