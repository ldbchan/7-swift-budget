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
        guard !repo.getAll().isEmpty else {
            return 0
        }
        return Double(
            repo.getAll().first!.amount
        )
    }
}
