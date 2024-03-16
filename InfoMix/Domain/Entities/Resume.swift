//
//  Resume.swift
//  InfoMix
//
//  Created by Temur on 07/04/22.
//  Copyright © 2022 InfoMix. All rights reserved.
//

import Foundation

struct Resume{
    var phone: String?
    var firstName: String?
    var lastName: String?
    var middleName: String?
    var birthday: Date?
    var aboutMe: String?
    var cityId: Int?
    var configCode : String?
    
    
}
extension Resume: Decodable{
    enum CodingKeys: String,CodingKey{
        case phone = "phone"
        case firstName = "firstName"
        case lastName = "lastName"
        case middleName = "middleName"
        case birthday = "birthday"
        case aboutMe = "aboutMe"
        case cityId = "cityId"
        case configCode = "configCode"
    }
    
    init(from decoder: Decoder) throws{
        let values = try decoder.container(keyedBy: CodingKeys.self)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        middleName = try values.decodeIfPresent(String.self, forKey: .middleName)
        birthday = try values.decodeIfPresent(Date.self, forKey: .birthday)
        aboutMe = try values.decodeIfPresent(String.self, forKey: .aboutMe)
        cityId = try values.decodeIfPresent(Int.self, forKey: .cityId)
        configCode = try values.decodeIfPresent(String.self, forKey: .configCode)
    }
}
