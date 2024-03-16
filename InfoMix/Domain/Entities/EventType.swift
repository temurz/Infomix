//
//  EventType.swift
//  CleanArchitecture
//
//  Created by Temur on 21/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import Foundation

struct EventType : Decodable, Identifiable, Hashable{
    var id : Int
    var name : String
}
