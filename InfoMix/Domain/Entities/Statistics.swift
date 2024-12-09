//
//  Statistics.swift
//  InfoMix
//
//  Created by Temur on 09/12/2024.
//  Copyright © 2024 InfoMix. All rights reserved.
//

import Foundation
struct Statistics: Decodable {
    let confirmed: Int?
    let dispute: Int?
    let checking: Int?
    let rejected: Int?
    let earned: Double?
    let products: Int?
}
