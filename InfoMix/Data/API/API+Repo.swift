//
//  API+Repo.swift
//  CleanArchitecture
//
//  Created by Tuan Truong on 7/31/20.
//  Copyright © 2020 Tuan Truong. All rights reserved.
//

import Alamofire

extension API {
    func getRepoList(_ input: GetRepoListInput) -> Observable<GetRepoListOutput> {
        return request(input)
    }
    
    final class GetRepoListInput: APIInput {
        init(dto: GetPageDto) {
            let params: Parameters = [
                "q": "language:swift",
                "per_page": dto.perPage,
                "page": dto.page
            ]
            
            super.init(urlString: API.Urls.eventDetail,
                       parameters: params,
                       method: .get,
                       requireAccessToken: true)
        
        }
    }
    
    final class GetRepoListOutput: Decodable {
        private(set) var repos: [Repo]?
        
        // swiftlint:disable:next nesting
        private enum CodingKeys: String, CodingKey {
            case repos = "items"
        }
    }
}
