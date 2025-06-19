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
    private let addVoucherTrigger = PassthroughSubject<Void, Never>()
    private let selectStatusTrigger = PassthroughSubject<String, Never>()
    private let requestVoucherTrigger = PassthroughSubject<(String, String), Never>()
    private let cancelRequestTrigger = PassthroughSubject<Int, Never>()
    private let getBarcodetrigger = PassthroughSubject<String, Never>()
    
    var body: some View {
        return LoadingView(isShowing: $output.isLoading, text: .constant("")) {
            ZStack(alignment: .bottomTrailing) {
                VStack {
                    VStack(spacing: 16) {
                        HStack {
                            Button {
                                backButtonTrigger.send(())
                            } label: {
                                Image(systemName: "chevron.left")
                                    .resizable()
                                    .foregroundStyle(.white)
                                    .aspectRatio(contentMode: .fit)
                                    .padding(2)
                                    .frame(width: 24, height: 24)
                            }
                            
                            Text("Get balls".localized())
                                .font(.headline)
                                .truncationMode(.middle)
                                .foregroundStyle(.white)
                            Spacer()
                            Button {
                                filterTrigger.send(())
                            } label: {
                                Text("Filter".localized())
                                    .foregroundStyle(.white)
                                    
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 8)
                        Text("NotePointPrice".localized())
                            .italic()
                            .foregroundStyle(.white)
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        ScrollView(.horizontal) {
                            HStack {
                                Spacer()
                                    .frame(width: 6)
                                ForEach(output.statuses) { status in
                                    VStack {
                                        Text(status.textField ?? "")
                                            .padding(.horizontal, 6)
                                            .foregroundStyle(status.selected ?? false ? .white : .black)
                                            .padding(.bottom, 4)
                                        if status.selected ?? false {
                                            Color.white
                                                .frame(height: 1)
                                        } else {
                                            Color.clear
                                                .frame(height: 1)
                                        }
                                    }
                                    .onTapGesture {
                                        selectStatusTrigger.send(status.valueField ?? "")
                                    }
                                    
                                }
                                Spacer()
                                    .frame(width: 6)
                            }
                        }
                        .scrollIndicators(.hidden)
                    }
                    .background(Colors.appMainColor)
                    if output.history.isEmpty {
                        VStack {
                            Spacer()
                            Text("No data".localized())
                                .font(.title3)
                                .foregroundStyle(.primary)
                                .bold()
                            Spacer()
                        }
                        
                    } else {
                        ScrollView {
                            ForEach(output.history) { history in
                                HistoryCell(model: history, cancelAction: {
                                    cancelRequestTrigger.send(history.id)
                                }, getBarcodeAction: {
                                    getBarcodetrigger.send(history.code ?? "")
                                })
                                    .frame(width: UIScreen.screenWidth)
                            }
                        }
                        .fixedSize(horizontal: true, vertical: false)
                    }
                    
                    Spacer()
                }
                Button {
                    addVoucherTrigger.send(())
                } label: {
                    Image("plus")
                        .centerCropped()
                        .padding(16)
                        .background(Colors.appMainColor)
                        .frame(width: 64, height: 64)
                        .cornerRadius(radius: 24, corners: .allCorners)
                        .shadow(radius: 1, x: 0, y: 2)
                }
                .padding()
                .padding(.trailing)
                
                if output.isShowingAddVoucher {
                    Color.black.opacity(0.4)
                        .onTapGesture {
                            output.isShowingAddVoucher = false
                        }
                        .ignoresSafeArea(.all)
                    VStack {
                        Spacer()
                        AddVoucherView(amount: $output.requestAmount, comment: $output.comment, errorText: $output.requestAmountError, balance: "\(output.balance)", cancelAction: {
                            output.requestAmount = ""
                            output.comment = ""
                            output.isShowingAddVoucher = false
                        }) {
                            requestVoucherTrigger.send((output.requestAmount, output.comment))
                        }
                        Spacer()
                    }
                }
                if output.showBarcode {
                    Color.black.opacity(0.4)
                        .onTapGesture {
                            output.showBarcode = false
                        }
                        .ignoresSafeArea(.all)
                    VStack(alignment: .center) {
                        Spacer()
                        BarcodeView(value: output.barcode) {
                            output.showBarcode = false
                        }
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    
                }
                if output.showFilter {
                    FilterPopUpView(fromDate: $output.fromDate, toDate: $output.toDate) {
                        output.showFilter = false
                    } updateAction: {
                        selectStatusTrigger.send(output.selectedStatus?.valueField ?? "")
                        output.showFilter = false
                    }
                    .ignoresSafeArea(.all)
                }
            }
        }
        .onAppear {
            onAppearTrigger.send(())
            selectStatusTrigger.send("New")
        }
        .alert(isPresented: $output.alert.isShowing) {
            Alert(
                title: Text(output.alert.title),
                message: Text(output.alert.message),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    
    init(viewModel: VoucherViewModel) {
        let input = VoucherViewModel.Input(
            popViewTrigger: backButtonTrigger.asDriver(),
            filterTrigger: filterTrigger.asDriver(),
            onAppearTrigger: onAppearTrigger.asDriver(),
            selectStatus: selectStatusTrigger.asDriver(),
            addVoucherTrigger: addVoucherTrigger.asDriver(),
            requestVoucherTrigger: requestVoucherTrigger.asDriver(),
            cancelRequestTrigger: cancelRequestTrigger.asDriver(),
            getBarcodetrigger: getBarcodetrigger.asDriver()
        )
        self.output = viewModel.transform(input, cancelBag: cancelBag)
    }
}


