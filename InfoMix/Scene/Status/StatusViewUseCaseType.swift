//
//  Untitled.swift
//  InfoMix
//
//  Created by Temur A. Zaitov on 24/12/24.
//  Copyright © 2024 InfoMix. All rights reserved.
//

protocol StatusViewUseCaseType {
    func getLoyalty() -> Observable<Loyalty>
    func getLeaderboard(page: Int) -> Observable<[LoyalUser]>
}

struct StatusViewUseCase: StatusViewUseCaseType, GetLoyaltyDomainUseCase, LeaderboardDomainUseCase {
    var gateway: LoyaltyGatewayType

    var leaderBoardGateway: LeaderBoardGatewayType

    func getLeaderboard(page: Int) -> Observable<[LoyalUser]> {
        let dto = GetPageDto(page: page, perPage: 10)
        return leaderBoardGateway.getLeaderboard(dto)
    }

}
