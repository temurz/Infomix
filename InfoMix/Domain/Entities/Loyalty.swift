//
//  Loyalty.swift
//  InfoMix
//
//  Created by Temur on 09/12/2024.
//  Copyright © 2024 InfoMix. All rights reserved.
//

import Foundation
struct Loyalty: Decodable {
    let id: Int?
    let createDate : Int?
    let name : String?
    let description : String?
    let targetCount : Int?
    let amount : Double?
    let isFixed : Bool?
    let jobId : Int??
    let backgroundColor : String?
    let icon : String?
    let nextLevel: NextLevel?
}

indirect enum NextLevel: Decodable {
    case loyalty(Loyalty)
}
