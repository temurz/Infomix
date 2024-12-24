//
//  MarketView.swift
//  InfoMix
//
//  Created by Temur A. Zaitov on 23/12/24.
//  Copyright © 2024 InfoMix. All rights reserved.
//

import SwiftUI

struct MarketView: View {

    @State var markets : [MarketItemViewModel]
    let cancelBag = CancelBag()
    let chosenMarket : (_ chosenMarketName: String, _ chosenMarketId: Int, _ hasChosen: Bool) -> Void
    var body: some View {
        ScrollView{
            ForEach(markets){market in
                Button {
                    self.chosenMarket(market.name ?? "",market.id, true)
                } label: {
                    VStack{
                        Text(market.name ?? "")
                        Divider()
                    }

                }

            }
        }
    }
}

struct MarketView_Previews: PreviewProvider {
    static var previews: some View {
        MarketView(markets: [MarketItemViewModel](), chosenMarket: {chosenMarketName,chosenMarketId, hasChosen in

        })
    }
}
