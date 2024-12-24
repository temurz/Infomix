//
//  API+Leaderboard.swift
//  InfoMix
//
//  Created by Temur A. Zaitov on 25/12/24.
//  Copyright © 2024 InfoMix. All rights reserved.
//

extension API {
    func getLeaderboard(_ input: LeaderboardAPIInput) -> Observable<[LoyalUser]> {
        requestList(input)
    }

    final class LeaderboardAPIInput: APIInput {
        init(_ dto: GetPageDto) {
            let params = [
                "rows" : dto.perPage,
                "page" : dto.page
            ]
            super.init(urlString: API.Urls.leaderboard, parameters: params, method: .get, requireAccessToken: true)
        }
    }
}
