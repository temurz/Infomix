//
//  CurrentUserUseCase.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 13/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

protocol CurrentUserUseCaseType {
    func getCurrentUser() -> Observable<Certificate>
}

struct CurrentUserUseCase: CurrentUserUseCaseType, GettingCurrentUser {
    let authGateway: AuthGatewayType    
  
}

