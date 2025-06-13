//
//  FcmTokenUseCase.swift
//  InfoMix
//
//  Created by Damir Asamatdinov on 05/02/22.
//  Copyright © 2022 InfoMix. All rights reserved.
//

import Foundation

protocol FcmTokenUseCaseType{
    func sendFcmToken(token: String) -> Observable<Bool>
}

struct FcmTokenUseCase : FcmTokenUseCaseType, SendingFcmToken {
    
    let authGateway: AuthGatewayType
    
}
