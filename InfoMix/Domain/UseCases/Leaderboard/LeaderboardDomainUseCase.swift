//
//  LeaderboardDomainUseCase.swift
//  InfoMix
//
//  Created by Temur A. Zaitov on 25/12/24.
//  Copyright © 2024 InfoMix. All rights reserved.
//

protocol LeaderboardDomainUseCase {
    var leaderBoardGateway: LeaderBoardGatewayType { get }
}

extension LeaderboardDomainUseCase {
    func getLeaderboard(_ dto: GetPageDto) -> Observable<PagingInfo<LoyalUser>> {
        return leaderBoardGateway.getLeaderboard(dto)
    }
}
