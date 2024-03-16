//
//  MyCardsUseCase.swift
//  InfoMix
//
//  Created by Temur on 26/01/22.
//  Copyright © 2022 InfoMix. All rights reserved.
//

import Foundation

protocol MyCardsDetailUseCaseType{
    func getCardDetail(id: Int) -> Observable<SerialCard>
}

struct MyCardsDetailUseCase: MyCardsDetailUseCaseType{
    let myCardsGateway: CardGateway
    
    func getCardDetail(id: Int) -> Observable<SerialCard> {
        myCardsGateway.getCardsDetail(id: id)
    }
    
}
