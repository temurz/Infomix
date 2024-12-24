//
//  CardGatewayType.swift
//  InfoMix
//
//  Created by Temur A. Zaitov on 21/12/24.
//  Copyright © 2024 InfoMix. All rights reserved.
//


//
//  CardGateway.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 23/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import Combine
import Foundation

protocol CardGatewayType {
    func connect() -> Observable<Int>
    func sendSerialNumbers(serialCardId: Int, serialNumbers: String)->Observable<SerialCard>
    func sendAdditionData(serialCardId: Int, installedDate: Date, data: [AddCardStepItem], latitude: Double?, longitude: Double?) -> Observable<SerialCard>
    func calculateBonuses(serialCardId: Int) -> Observable<Transaction>
    func getCardsHistory(dto: GetPageDto) -> Observable<PagingInfo<SerialCard>>
    func getCardsDetail(id: Int) -> Observable<SerialCard>
    func sendImageValue(inputData: ImageValueInput) -> Observable<SerialCard>
}

struct CardGateway: CardGatewayType {
    func sendImageValue(inputData: ImageValueInput) -> Observable<SerialCard> {
        let input = API.SendingImageValueInput(imageValueInput: inputData)
        return API.shared.sendImageValue(input: input)
            .eraseToAnyPublisher()
    }
    
    func getCardsDetail(id: Int) -> Observable<SerialCard> {
        let input = API.GetCardsDetailInput(id: id)
        
        return API.shared.getCardsDetail(input)
            .eraseToAnyPublisher()
    }
    
    func getCardsHistory(dto: GetPageDto) -> Observable<PagingInfo<SerialCard>> {
        let input = API.GetCardsHistoryInput(dto: dto)
        
        return API.shared.getCardsHistoryList(input)
            .map{(output) -> [SerialCard]? in
                return output
            }
            .replaceNil(with: [])
            .map { PagingInfo(page: dto.page, items: $0, hasMorePages: $0.count == dto.perPage)}
            .eraseToAnyPublisher()
    }
    
    func calculateBonuses(serialCardId: Int) -> Observable<Transaction> {
        let input = API.SendingDone(serialCardId: serialCardId)
        
        return API.shared.done(input)
    }
    
    func sendAdditionData(serialCardId: Int, installedDate: Date, data: [AddCardStepItem], latitude: Double?, longitude: Double?) -> Observable<SerialCard> {
        let input = API.SendingAdditionalData(serialCardId: serialCardId, data: data, installedDate: installedDate, longitude: longitude, latitude: latitude)
        
        return API.shared.sendAddtionalData(input)
    }
    
    func sendSerialNumbers(serialCardId: Int, serialNumbers: String) -> Observable<SerialCard> {
        let input = API.SendingSerialNumbers(serialCardId: serialCardId,serialNumbers: serialNumbers)
        return API.shared.sendSerialNumbers(input)
    }
    
    
    func connect() -> Observable<Int> {
        let input = API.SendingConnectInput()
        
        return API.shared.connect(input).map { it in
            Int(truncatingIfNeeded: it)
        }.eraseToAnyPublisher()
    }
 
    
    
}