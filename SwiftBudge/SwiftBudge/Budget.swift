//
//  swift
//  SwiftBudge
//
//  Created by chantil on 2023/3/16.
//

import Foundation

struct Budget {
    let yearMonth: String
    let amount: Int

    func firstDay() -> Date {
        Date(yearMonth, format: "yyyyMM").firstDayOfMonth()
    }

    func lastDay() -> Date {
        Date(yearMonth, format: "yyyyMM").lastDayOfMonth()
    }

    func dailyAmount() -> Double {
        Double(amount) / Double(Date(yearMonth, format: "yyyyMM").lengthOfMonth())
    }

    func period() -> Period {
        Period(start: firstDay(), end: lastDay())
    }
}
