//
//  LocalUserUseCase.swift
//  InfoMix
//
//  Created by Damir Asamatdinov on 25/01/22.
//  Copyright © 2022 InfoMix. All rights reserved.
//

protocol GetLocalUsersUseCaseType {
    func getLocalUsers() -> Observable<[LocalUser]>
}

struct GetLocalUsersUseCase: GetLocalUsersUseCaseType, GettingLocalUsers {
    let localUserGateway: LocalUserGatewayType
}
