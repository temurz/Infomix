//
//  HistoryRow.swift
//  CleanArchitecture
//
//  Created by Temur on 08/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//
import SwiftUI

struct TransactionHistoryRow: View {
    @Binding var transactionRow : TransactionHistoryItemViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 12){
            HStack(alignment: .top){
                if transactionRow.amountMethod == 1 {
                    Image(systemName: "arrow.down.circle")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.green)
                        .padding(.horizontal)
                }else{
                    Image(systemName: "arrow.up.circle")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.red)
                        .padding(.horizontal)
                }
                
                VStack(alignment: .leading){
                    if let date = transactionRow.createDate{
                        Text(date.toShortFormat())
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                    }
                    if transactionRow.amountMethod == 1{
                        Text("+" + String(transactionRow.amountMethod ?? 1) + " ball".localized())
                            .font(.system(size: 16))
                            .foregroundColor(.green)
                    }else{
                        Text(String(transactionRow.amountMethod ?? 1) + " ball".localized())
                            .font(.system(size: 16))
                            .foregroundColor(.red)
                    }
                    
                    if let comment = transactionRow.comment{
                        Text(comment)
                            .font(.system(size: 12))
                            .foregroundColor(.black)
                    }
                }
                Spacer()
                if transactionRow.amountMethod == 1{
                    HStack(alignment: .center, spacing: 5) {
                        if let typeText = transactionRow.typeText{
                            Text(typeText)
                                .font(.system(size: 12))
                                .foregroundColor(.white)
                                .padding(.horizontal, 6)
                        }
                    }.frame(height: 20)
                        .background(Color.green)
                        .cornerRadius(10)
                }else{
                    HStack(alignment: .center, spacing: 5) {
                        if let typeText = transactionRow.typeText{
                            Text(typeText)
                                .font(.system(size: 12))
                                .foregroundColor(.white)
                                .padding(.horizontal, 6)
                        }
                    }.frame(height: 20)
                        .background(Color.red)
                        .cornerRadius(10)
                }
                
            }
        }
        .padding(.init(top: 8, leading: 6, bottom: 0, trailing: 8))
    }
}

struct HistoryRow_Previews: PreviewProvider {
    static var previews: some View {
        let transaction = Transaction(id: 1, transactionType: "", amount: 1, amountMethod: 1, comment: "", createDate: Date(), typeText: "", entityStatus: nil)
        TransactionHistoryRow(transactionRow: .constant(TransactionHistoryItemViewModel(transaction: transaction)))
    }
}
