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

public extension Validation where Value == Data{

    static func hasImageData(message: String) -> Validation{
        return .init{value in
            if !value.isEmpty{
                return .success(())
            }else {
                return .failure(ValidationError(message: message))
            }
        }
    }
}

public extension Validation where Value == Int {

    static func idValid(message: String) -> Validation{
        return .init {id in
            if id > 0 {
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

public extension Validation where Value == String {

    /// The non empty Validation with error message
    static func amountMoreThan(_ amount: Double, message: String) -> Validation {
        return .init { value in
            if value.isEmpty || Double(value) ?? 0 < amount {
                return .failure(ValidationError(message: message))
            } else {
                return .success(())
            }
        }
    }
}
