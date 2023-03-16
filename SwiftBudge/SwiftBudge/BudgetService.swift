//
//  BudgetService.swift
//  SwiftBudge
//
//  Created by chantil on 2023/3/16.
//

import Foundation

class BudgetService {
    let repo: BudgetRepository

    init(repo: BudgetRepository) {
        self.repo = repo
    }

    func query(start: Date, end: Date) -> Double {
        guard case let budgets = repo.getAll(), !budgets.isEmpty else {
            return 0
        }

        let budget = budgets.first!
        let overlappingStart = budget.firstDay() > start ? budget.firstDay() : start
        let intervalDays = Date.numberOfDaysBetween(overlappingStart, end)

        if start > budget.lastDay() {
            return 0
        }
        if end < budget.firstDay() {
            return 0
        }
        return Double(intervalDays)
    }
}
