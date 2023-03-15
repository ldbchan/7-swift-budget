//
//  BudgetRepository.swift
//  SwiftBudge
//
//  Created by chantil on 2023/3/15.
//

import Foundation

protocol BudgetRepository {
    func getAll() -> [Budget]
}
