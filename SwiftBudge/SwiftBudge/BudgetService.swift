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
        let intervalDays = Date.numberOfDaysBetween(start, end)

        let budget = budgets.first!

        if start > budget.lastDay() {
            return 0
        }
        if end < budget.firstDay() {
            return 0
        }
        return Double(intervalDays)
    }
}
