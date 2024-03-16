//
//  Validation+Collection.swift
//  CleanArchitecture
//
//  Created by Tuan Truong on 9/1/20.
//  Copyright © 2020 Tuan Truong. All rights reserved.
//

import ValidatedPropertyKit

public extension Validation where Value: Collection {
    
    /// The non empty Validation with error message
    static func nonEmpty(message: String) -> Validation {
        return .init { value in
            if !value.isEmpty {
                return .success(())
            } else {
                return .failure(ValidationError(message: message))
            }
        }
    }
}

public extension Validation where Value == Bool {
    
    static func notCity(message: String) -> Validation{
        return .init {city in
            if city {
                return .success(())
            }else{
                return .failure(ValidationError(message: message))
            }
            
        }
    }
}

public extension Validation where Value : Collection{
    
    static func notPhoneNumber(message: String) -> Validation{
        return .init { value in
            if value.count == 13{
                return .success(())
            }else{
                return .failure(ValidationError(message: message))
            }
        }
    }
}

public extension Validation where Value == Date{
    
    static func checkAge(message: String) -> Validation{
        let currentCalendar = Calendar.current
        
        return .init { value in
            let age = currentCalendar.dateComponents([.year], from: value, to: Date())
            if age.year ?? 18 >= 18 {
                return .success(())
            }else{
                return .failure(ValidationError(message: message))
            }
        }
    }
}
