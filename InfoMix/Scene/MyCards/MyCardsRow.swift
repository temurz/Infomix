//
//  MyCardsRow.swift
//  InfoMix
//
//  Created by Temur on 24/01/22.
//  Copyright © 2022 InfoMix. All rights reserved.
//

import SwiftUI

struct MyCardsRow: View {
    let viewModel: MyCardItemViewModel
    
    var body: some View {
        VStack(alignment: .leading){
            HStack(spacing: 12){
                VStack(alignment:.leading){
                    HStack{
                        Text("Card #".localized())
                            .foregroundColor(.black)
                            .bold()
                            .font(.system(size: 16))
                        Text(String(viewModel.id))
                            .foregroundColor(.black)
                            .bold()
                            .font(.system(size: 16))
                    }
                   
                    Text("Serial number:".localized())
                        .font(.system(size: 12))
                        .foregroundColor(Color.gray)
                }
                VStack{
                    Spacer()
                    
                    Text(viewModel.serialCard.serialNumbers?[0].serialNumber ?? "")
                        .font(.system(size: 12))
                }
                VStack{
                    
                    if let date = viewModel.createDate {
                        Text(date.toShortFormat())
                            .font(.system(size: 12))
                            .foregroundColor(Color.gray)
                    }
                    Spacer()
                }
                VStack(alignment: .center){
                    Image(systemName: "arrow.right")
                        .foregroundColor(Color.green)
                }
            }
            .padding(.horizontal)
            Divider()
        }
    }
}

struct MyCardsRow_Previews: PreviewProvider {
    static var previews: some View {
        let serialCard = SerialCard(id: 1, status: "", serialNumbers: [SerialNumber](),createDate: Date(),modifyDate: Date(), customer: Customer(phone: ""))
        MyCardsRow(viewModel: MyCardItemViewModel(serialCard: serialCard))
    }
}
