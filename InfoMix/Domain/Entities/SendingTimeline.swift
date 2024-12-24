//
//  SendingTimeline.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 23/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import Foundation
import Metal
import SwiftUI

enum SendingTimelineStatus{
    case loading, success, error, dispute, done, warning, note
}

enum SendingTimelineId: String {
    case connect, serialNumbers, additionalData, calculateBonus, done, dispute, imageValue
}

struct SendingTimeline: Identifiable {
    let id:String
    var status:SendingTimelineStatus = .loading
    var title: String
    var content: String?
    var date: Date = Date()
    var input: Any?
    var disputeInput: OpenDisputeInput? = nil
    var inDispute = false
}


extension SendingTimeline {
    func clone(status: SendingTimelineStatus, title: String, _ content: String? = nil) -> SendingTimeline{
        SendingTimeline(id: self.id, status: status , title: title, content: content, date: self.date, input: self.input, disputeInput: self.disputeInput, inDispute: self.inDispute)
    }
}
