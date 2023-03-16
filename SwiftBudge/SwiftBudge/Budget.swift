//
//  Budget.swift
//  SwiftBudge
//
//  Created by chantil on 2023/3/15.
//

import Foundation

typealias YearMonth = String

struct Budget {
    let yearMonth: YearMonth
    let amount: Int

    func firstDay() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMM"
        let date = dateFormatter.date(from: yearMonth)!
        return date.firstDayInMonth()
    }

    func lastDay() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMM"
        let date = dateFormatter.date(from: yearMonth)!
        return date.lastDayInMonth()
    }

    func period() -> Period {
        Period(start: firstDay(), end: lastDay())
    }

    func dailyAmount() -> Double {
        Double(amount) / Double(firstDay().lengthOfMonth())
    }
}
