//
//  MyCardsDetailView.swift
//  InfoMix
//
//  Created by Temur on 25/01/22.
//  Copyright © 2022 InfoMix. All rights reserved.
//

import SwiftUI
import Combine
struct MyCardsDetailView: View {
    
    
    @ObservedObject var output: MyCardsDetailViewModel.Output
    private let loadTrigger = PassthroughSubject<Int,Never>()
    private let popViewTrigger = PassthroughSubject<Void,Never>()
    private let cancelBag = CancelBag()
    var body: some View {
        VStack {
            CustomNavigationBar(title: "Card #".localized() + "\(output.serialCard.id)") {
                popViewTrigger.send(())
            }
            HStack {
            VStack(alignment: .leading, spacing: 12){
                VStack(alignment: .leading){
                    Text("Date of install".localized())
                        .foregroundColor(.gray)
                    if let date = output.serialCard.createDate{
                        Text(date.toShortFormat())
                    }

                }
                .padding()
                VStack(alignment: .leading){
                    Text("Client's phone number".localized())
                        .foregroundColor(.gray)
                    if let customer = output.serialCard.customer{
                        Text(customer.phone ?? "")
                    }

                }
                .padding()

                VStack(alignment: .leading){
                    if let card = output.serialCard.serialNumbers{
                        Text("Model".localized() + ": " + (card[0].model?.name ?? ""))
                        Text(card[0].serialNumber ?? "")
                    }
                }
                .padding()

                Spacer()
            }
                Spacer()
            }
        }
        
    }
    init(viewModel: MyCardsDetailViewModel){
        let input = MyCardsDetailViewModel.Input(
            loadTrigger: loadTrigger.asDriver(),
            popViewTrigger: popViewTrigger.asDriver()
        )
        self.output = viewModel.transform(input, cancelBag: cancelBag )
        loadTrigger.send(viewModel.serialCard.id)
    }
}

struct MyCardsDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let serialCard = SerialCard(id: 1, status: "", serialNumbers: [SerialNumber](), createDate: Date(), modifyDate: Date(), customer: Customer(phone: ""))
        MyCardsDetailView(viewModel: MyCardsDetailViewModel(useCase: PreviewAssembler().resolve(), serialCard: serialCard))
    }
}
