//
//  About.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 19/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Foundation

struct About {
    let phone: String?
    let phoneWithoutSpace: String?
    let telegramAccount: String?
    let facebookAccount: String?
    let istagramAccount: String?
}

extension About{
    static func airfel()-> About{
        return About(phone: "+998 88 187 18 71", phoneWithoutSpace: "+998881871871", telegramAccount: "ArtMaster", facebookAccount: nil, istagramAccount: nil)
    }
}
