//
//  LeaderboardGateway.swift
//  InfoMix
//
//  Created by Temur A. Zaitov on 25/12/24.
//  Copyright © 2024 InfoMix. All rights reserved.
//

protocol LeaderBoardGatewayType {
    func getLeaderboard(_ dto: GetPageDto) -> Observable<PagingInfo<LoyalUser>>
}

struct LeaderBoardGateway: LeaderBoardGatewayType {
    func getLeaderboard(_ dto: GetPageDto) -> Observable<PagingInfo<LoyalUser>> {
        let input = API.LeaderboardAPIInput(dto)
        return API.shared.getLeaderboard(input)
            .map{(output) -> [LoyalUser]? in
                return output
            }
            .replaceNil(with: [])
            .map { PagingInfo(page: dto.page, items: $0, hasMorePages: $0.count == dto.perPage)}
            .eraseToAnyPublisher()
    }
}
