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
    func sendSerialNumbers(serialCardId: Int, serialNumbers: [SerialNumberInput])->Observable<SerialCard>
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
    
    func sendSerialNumbers(serialCardId: Int, serialNumbers: [SerialNumberInput]) -> Observable<SerialCard> {
        let input = API.SendingSerialNumbers(serialCardId: serialCardId,serialNumbers: serialNumbers)
        return API.shared.sendSerialNumbers(input)
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
    
    
    func connect() -> Observable<Int> {
        let input = API.SendingConnectInput()
        
        return API.shared.connect(input).map { it in
            it.id
        }.eraseToAnyPublisher()
    }
 
    
    
}

struct PreviewCardGateway: CardGatewayType {
    func sendImageValue(inputData: ImageValueInput) -> Observable<SerialCard> {
        return .empty()
    }
    
    func getCardsDetail(id: Int) -> Observable<SerialCard> {
        Future<SerialCard,Error> {promise in
            let card = SerialCard(id: 0, status: "", serialNumbers: [SerialNumber](), createDate: Date(), modifyDate: Date(), customer: Customer(phone: ""))
            promise(.success(card))
        }
        .eraseToAnyPublisher()
    }
    
    func getCardsHistory(dto: GetPageDto) -> Observable<PagingInfo<SerialCard>> {
        Future<PagingInfo<SerialCard>,Error> {promise in
            let cards = [SerialCard(id: 1, status: "", serialNumbers: [SerialNumber](),createDate: Date(),modifyDate: Date(), customer: Customer(phone: ""))]
            let page = PagingInfo<SerialCard>(page: 1, items: cards)
            promise(.success(page))
        }
        .eraseToAnyPublisher()
    }
    
    func calculateBonuses(serialCardId: Int) -> Observable<Transaction> {
        Future<Transaction, Error> { promise in
            promise(.success(Transaction(id: 1, transactionType: nil, amount: nil, amountMethod: nil, comment: nil, createDate: nil, typeText: nil, entityStatus: nil)))
        }
        .eraseToAnyPublisher()
    }
    
    func sendAdditionData(serialCardId: Int, installedDate: Date, data: [AddCardStepItem], latitude: Double?, longitude: Double?) -> Observable<SerialCard> {
        Future<SerialCard, Error> { promise in
            promise(.success(SerialCard(id: 1, status: "Done", serialNumbers: [SerialNumber](),createDate: Date(),modifyDate: Date(), customer: Customer(phone: ""))))
        }
        .eraseToAnyPublisher()
    }
    
    
    func sendSerialNumbers(serialCardId: Int, serialNumbers: [SerialNumberInput]) -> Observable<SerialCard> {
        Future<SerialCard, Error> { promise in
            promise(.success(SerialCard(id: 1, status: "Done", serialNumbers: [SerialNumber](),createDate: Date(),modifyDate: Date(), customer: Customer(phone: ""))))
        }
        .eraseToAnyPublisher()
    }
    
    func connect() -> Observable<Int> {
        Future<Int, Error> { promise in
            promise(.success(1))
        }
        .eraseToAnyPublisher()
    }
    
}

