//
//  Data+Extensions.swift
//  SwiftBudge
//
//  Created by chantil on 2023/3/16.
//

import Foundation

extension Date {
    func lengthOfMonth() -> Int {
        Calendar.current.dateComponents([.year, .month, .day], from: lastDayOfMonth()).day!
    }

    func firstDayOfMonth() -> Date {
        Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }

    func lastDayOfMonth() -> Date {
        Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: firstDayOfMonth())!
    }

    func toString(_ format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: Calendar.current.startOfDay(for: self))
    }

    init(_ string: String, format: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        self = Calendar.current.startOfDay(for: dateFormatter.date(from: string)!)
    }
}
