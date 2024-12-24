//
//  OrderHistoryItemView.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 12/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import SwiftUI

struct OrderHistoryItemView: View {
    
    @Binding var order: Order
    
    var body: some View {
       
        
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top) {
                Text("Order: ".localized() + "\(self.order.id)")
                    .font(.headline)
                    .foregroundColor(.black)
                    .lineLimit(1)
                
                Spacer(minLength: 10)
                HStack(alignment: .center, spacing: 5) {
                    
                    Text("\(self.order.status ?? "")")
                        .font(.system(size: 12))
                        .foregroundColor(.white)
                        .padding(.horizontal, 6)
                }.frame(height: 20)
                    .background(Color.gray)
                    .cornerRadius(10)
                
            }
            
            Text(String(format: "Created date: %@".localized(), self.order.createdDate?.toShortFormat() ?? ""))
                .font(.system(size: 14))
                .foregroundColor(Color.init(.systemGray))
            Spacer()
            HStack {
                HStack {
                    
                    Text(String(self.order.totalProducts) + " items".localized())
                        .font(.system(size: 13))
                        .foregroundColor(.black)
                        .padding(5)
                    
                }
                .background(Color.init(.systemGray6))
                .cornerRadius(5)
                Spacer()
                Text("\(self.order.totalAmount.groupped(fractionDigits: 0, groupSeparator: " "))" + " ball".localized())
                    .font(.body)
                    .foregroundColor(.black)
            }
            
        }
        .padding(.init(top: 8, leading: 6, bottom: 0, trailing: 8))
    }
}
