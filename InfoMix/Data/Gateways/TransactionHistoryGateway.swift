//
//  TransactionHistoryGateway.swift
//  CleanArchitecture
//
//  Created by Temur on 08/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Foundation
import Combine

protocol TransactionHistoryGatewayType {
    func getTransactionHistory(dto: GetPageDto, from: Date, to: Date, type : String) -> Observable<PagingInfo<Transaction>>
    func getTransactionTypes() -> Observable<[TransactionType]>
    func getTransactionStatistic(from: Date, to: Date) -> Observable<TransactionStatistic>
}

struct TransactionHistoryGateway : TransactionHistoryGatewayType{
    func getTransactionStatistic(from: Date, to: Date) -> Observable<TransactionStatistic> {
        let input = API.GetTransactionStatistic(from: from,to: to)
        
        return API.shared.getTransactionStatistic(input)
            .map { (output) -> TransactionStatistic? in
                return output
            }
            .replaceNil(with: TransactionStatistic(coming: 0, expense: 0, date: Date()))
            .eraseToAnyPublisher()
    }
    
    
    func getTransactionHistory(dto: GetPageDto, from: Date, to: Date, type: String) -> Observable<PagingInfo<Transaction>> {
        let input = API.GetTransactionHistoryList(dto: dto, from: from, to: to, type: type)
        
        return API.shared.getTransactionHistoryList(input)
            .map { (output) -> [Transaction]? in
                return output
            }
            .replaceNil(with: [])
            .map { PagingInfo(page: dto.page, items: $0, hasMorePages: $0.count == dto.perPage)}
            .eraseToAnyPublisher()
    }
    func getTransactionTypes() -> Observable<[TransactionType]> {
        let input = API.GetTransactionTypeList()
        return API.shared.getTransactionTypeList(input)
            .map { (output) -> [TransactionType]? in
                return output
                
            }
            .replaceNil(with: [])
            .eraseToAnyPublisher()
        
    }
}

struct PreviewTransactionHistoryGateway : TransactionHistoryGatewayType{
    func getTransactionStatistic(from: Date, to: Date) -> Observable<TransactionStatistic> {
        Future<TransactionStatistic,Error> {promise in
            let transactionStatistic = TransactionStatistic(coming: 0,
                                                        expense: 0,
                                                        date: Date())
            
            promise(.success(transactionStatistic))
            
        }
        .eraseToAnyPublisher()
    }
    
    func getTransactionHistory(dto: GetPageDto, from: Date, to: Date, type: String) -> Observable<PagingInfo<Transaction>> {
        Future<PagingInfo<Transaction>, Error> { promise in
            let transactions = [
                Transaction(id: 1, transactionType: "",
                           amount: 1,
                           amountMethod: 1,
                           comment: "",
                           createDate: Date(),
                            typeText: "",
                            entityStatus: nil)
            ]
            
            let page = PagingInfo<Transaction>(page: 1, items: transactions)
            promise(.success(page))
        }
        .eraseToAnyPublisher()
    }
    func getTransactionTypes() -> Observable<[TransactionType]> {
        Future<Array<TransactionType>,Error> { promise in
            let transactionTypes = [
                TransactionType(textField: "", valueField: "")
            ]
            
            promise(.success(transactionTypes))
        }
        .eraseToAnyPublisher()
    }
}
