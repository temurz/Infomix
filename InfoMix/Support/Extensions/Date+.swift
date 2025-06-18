//
//  Date+.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 24/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import Foundation

extension Date {
    func toApiFormat()->String{
        
        // Create Date Formatter
        let dateFormatter = DateFormatter()

        // Set Date Format
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"

        // Convert Date to String
        return dateFormatter.string(from: self)
    }
    
    func toShortFormat()->String{
        
        // Create Date Formatter
        let dateFormatter = DateFormatter()

        // Set Date Format
        dateFormatter.dateFormat = "dd-MM-yyyy"

        // Convert Date to String
        return dateFormatter.string(from: self)
    }
    
        var startOfDay: Date {
            return Calendar.current.startOfDay(for: self)
        }

        var startOfMonth: Date {

            let calendar = Calendar(identifier: .gregorian)
            let components = calendar.dateComponents([.year, .month], from: self)

            return  calendar.date(from: components)!
        }

        var endOfDay: Date {
            var components = DateComponents()
            components.day = 1
            components.second = -1
            return Calendar.current.date(byAdding: components, to: startOfDay)!
        }

        var endOfMonth: Date {
            var components = DateComponents()
            components.month = 1
            components.second = -1
            return Calendar(identifier: .gregorian).date(byAdding: components, to: startOfMonth)!
        }

        func isMonday() -> Bool {
            let calendar = Calendar(identifier: .gregorian)
            let components = calendar.dateComponents([.weekday], from: self)
            return components.weekday == 2
        }
}

extension Int {
    func formatTimestamp() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self) / 1000)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        formatter.timeZone = TimeZone.current // or set explicitly if needed
        return formatter.string(from: date)
    }
}
