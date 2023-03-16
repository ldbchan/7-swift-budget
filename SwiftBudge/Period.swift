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

    func days() -> Int {
        let numberOfDays = Calendar.current.dateComponents([.day], from: start, to: end)
        return numberOfDays.day! + 1
    }
}
