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
        let intervalDays = Period(start: start, end: end).overlappingDays(budget.period())

        return Double(intervalDays) * budget.dailyAmount()
    }
}
