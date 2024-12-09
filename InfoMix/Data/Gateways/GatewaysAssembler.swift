//
//  GatewaysAssembler.swift
//  CleanArchitecture
//
//  Created by Tuan Truong on 7/14/20.
//  Copyright © 2020 Tuan Truong. All rights reserved.
//

protocol GatewaysAssembler {
    func resolve() -> ProductGatewayType
    func resolve() -> AuthGatewayType
    func resolve() -> RepoGatewayType
    func resolve() -> AgentGatewayType
    func resolve() -> CardConfigGatewayType
    func resolve() -> EventGatewayType
    func resolve() -> CardGatewayType
    func resolve() -> DisputeGatewayType
    func resolve() -> ShoppingGatewayType
    func resolve() -> ProductCategoryGatewayType
    func resolve() -> TransactionHistoryGatewayType
    func resolve() -> LocalUserGatewayType
}

extension GatewaysAssembler where Self: DefaultAssembler {
    func resolve() -> ProductGatewayType {
        ProductGateway()
    }

    func resolve() -> AuthGatewayType {
        AuthGateway()
    }

    func resolve() -> RepoGatewayType {
        RepoGateway()
    }
    
    func resolve() -> AgentGatewayType {
        AgentGateway()
    }
    func resolve() -> CardConfigGatewayType{
        CardConfigGateway()
    }
    func resolve() -> EventGatewayType {
        EventGateway()
    }
    func resolve() -> CardGatewayType {
        CardGateway()
    }
    
    func resolve() -> TransactionHistoryGatewayType {
        TransactionHistoryGateway()
    }
    
    func resolve() -> DisputeGatewayType{
        DisputeGateway()
    }
    
    func resolve() -> ShoppingGatewayType{
        ShoppingGateway()
    }
    
    func resolve() -> ProductCategoryGatewayType{
        ProductCategoryGateway()
    }
    
    func resolve() -> LocalUserGatewayType{
        LocalUserGateway()
    }
    
    func resolve() -> LoyaltyGatewayType {
        LoyaltyGateway()
    }
    
    func resolve() -> StatisticsGatewayType {
        StatisticsGateway()
    }
}

extension GatewaysAssembler where Self: PreviewAssembler {
    func resolve() -> ProductGatewayType {
        PreviewProductGateway()
    }
    
    func resolve() -> AuthGatewayType {
        AuthGateway()
    }
    
    func resolve() -> RepoGatewayType {
        PreviewRepoGateway()
    }
    
    func resolve() -> AgentGatewayType {
        PreviewAgentGateway()
    }
    
    func resolve() -> CardConfigGatewayType{
        PreviewCardConfigGateway()
    }
    func resolve() -> EventGatewayType {
        PreviewEventGateway()
    }
    func resolve() -> CardGatewayType {
        PreviewCardGateway()
    }
    
    func resolve() -> DisputeGatewayType{
        PreviewDisputeGateway()
    }
    
    func resolve() -> ShoppingGatewayType{
        PreviewShoppingGateway()
    }
    
    func resolve() -> ProductCategoryGatewayType{
        ProductCategoryGateway()
    }
    
    func resolve() -> TransactionHistoryGatewayType {
        PreviewTransactionHistoryGateway()
    }
    
    func resolve() -> LocalUserGatewayType{
        LocalUserGateway()
    }
    
    func resolve() -> LoyaltyGatewayType {
        LoyaltyGateway()
    }
    
    func resolve() -> StatisticsGatewayType {
        StatisticsGateway()
    }
}
