//
//  GettingCardsHistory.swift
//  InfoMix
//
//  Created by Temur on 25/01/22.
//  Copyright © 2022 InfoMix. All rights reserved.
//

import Foundation

protocol GettingCardsHistory{
    var cardGateway: CardGateway { get }
}
extension GettingCardsHistory{
    
    func getCardsHistory(dto: GetPageDto) -> Observable<PagingInfo<SerialCard>>{
        cardGateway.getCardsHistory(dto: dto)
    }
}
