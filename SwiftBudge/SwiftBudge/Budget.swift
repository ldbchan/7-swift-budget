//
//  Budget.swift
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
}
