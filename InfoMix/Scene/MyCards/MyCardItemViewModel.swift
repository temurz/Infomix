//
//  MyCardItemViewModel.swift
//  InfoMix
//
//  Created by Temur on 25/01/22.
//  Copyright © 2022 InfoMix. All rights reserved.
//

import Foundation

struct MyCardItemViewModel: Identifiable {
    let serialCard: SerialCard
    let id : Int
    let status: String
    let serialNumber: [SerialNumber]?
    let createDate: Date?
    let modifyDate: Date?
    
    init(serialCard: SerialCard){
        self.serialCard = serialCard
        self.id = serialCard.id
        self.status = serialCard.status ?? ""
        self.serialNumber = serialCard.serialNumbers
        self.createDate = serialCard.createDate
        self.modifyDate = serialCard.modifyDate
        
    }
}
