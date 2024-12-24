//
//  SendingOnlineApplication.swift
//  InfoMix
//
//  Created by Temur A. Zaitov on 23/12/24.
//  Copyright © 2024 InfoMix. All rights reserved.
//

import Foundation

protocol SendingOnlineApplication{
    var onlineApplicationGateway : OnlineApplicationGatewayType { get }
}

extension SendingOnlineApplication{
    func sendOnlineApplication(dto: OnlineApplicationDto) -> Observable<Bool>{
        onlineApplicationGateway.sendOnlineApplication(dto: dto)
    }
}
