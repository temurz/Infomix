//
//  OnlineApplicationGateway.swift
//  InfoMix
//
//  Created by Temur A. Zaitov on 23/12/24.
//  Copyright © 2024 InfoMix. All rights reserved.
//

import Foundation

protocol OnlineApplicationGatewayType{
    func sendOnlineApplication(dto: OnlineApplicationDto) ->Observable<Bool>
}

struct OnlineApplicationGateway : OnlineApplicationGatewayType{

    func sendOnlineApplication(dto:OnlineApplicationDto) -> Observable<Bool> {

        let input = API.SendingResumeInput(dto: dto)

        return API.shared.sendResume(input)
    }




}
