//
//  MyCardsUseCase.swift
//  InfoMix
//
//  Created by Temur on 24/01/22.
//  Copyright © 2022 InfoMix. All rights reserved.
//

import Foundation

protocol MyCardsUseCaseType {
    func getCardsHistory(page: Int) -> Observable<PagingInfo<SerialCard>>
}

struct MyCardsUseCase: MyCardsUseCaseType, GettingCardsHistory {
    var cardGateway: CardGateway
    
    func getCardsHistory(page: Int) -> Observable<PagingInfo<SerialCard>> {
        let dto = GetPageDto(page: page, perPage: 10)
        return getCardsHistory(dto: dto)
    }
    
    
}
