//
//  Period.swift
//  SwiftBudge
//
//  Created by chantil on 2023/3/16.
//

import Foundation

struct Period {
    let start: Date
    let end: Date

    func overlappingDays(_ another: Period) -> Int {
        if start > another.end || end < another.start {
            return 0
        }
        let overlappingStart = another.start > start ? another.start : start
        let overlappingEnd = another.end < end ? another.end : end
        return Date.numberOfDaysBetween(overlappingStart, overlappingEnd)
    }

}
