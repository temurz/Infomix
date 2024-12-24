//
//  ResumeField.swift
//  Viessmann
//
//  Created by Temur on 09/06/22.
//  Copyright © 2022 Viessmann. All rights reserved.
//

import Foundation

struct ResumeField : Identifiable{
    
    var id : Int?
    var field : String
    var enabled : Bool
    var requiredField : Bool
}

extension ResumeField : Decodable{
    enum CodingKeys : String, CodingKey{
        case id = "id"
        case field = "field"
        case enabled = "enabled"
        case requiredField = "required"
    }
    
    init(from decoder: Decoder) throws{
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        field = try values.decodeIfPresent(String.self, forKey: .field) ?? ""
        enabled = try values.decodeIfPresent(Bool.self, forKey: .enabled) ?? false
        requiredField = try values.decodeIfPresent(Bool.self, forKey: .requiredField) ?? false
    }
    
    func isEnabledAndEqual(_ field: String)->Bool{
        return self.field == field && self.enabled
    }
}
