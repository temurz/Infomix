//
//  LeaderboardGateway.swift
//  InfoMix
//
//  Created by Temur A. Zaitov on 25/12/24.
//  Copyright © 2024 InfoMix. All rights reserved.
//

protocol LeaderBoardGatewayType {
    func getLeaderboard(_ dto: GetPageDto) -> Observable<[LoyalUser]>
}

struct LeaderBoardGateway: LeaderBoardGatewayType {
    func getLeaderboard(_ dto: GetPageDto) -> Observable<[LoyalUser]> {
        let input = API.LeaderboardAPIInput(dto)
        return API.shared.getLeaderboard(input)
            .eraseToAnyPublisher()
    }
}
