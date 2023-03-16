//
//  SwiftBudgeTests.swift
//  SwiftBudgeTests
//
//  Created by chantil on 2023/3/15.
//

import XCTest
@testable import SwiftBudge

final class SwiftBudgeTests: XCTestCase {
    var repo: FakeBudgetRepository!
    var budgetService: BudgetService!

    override func setUp() {
        super.setUp()
        repo = FakeBudgetRepository()
        budgetService = BudgetService(repo: repo)
    }

    func test_no_budgets() {
        totalAmountShouldBe(start: "20230401", end: "20230403", expected: 0)
    }

    func test_query_whole_month() {
        givenBudgets(Budget(yearMonth: "202304", amount: 30))
        totalAmountShouldBe(start: "20230401", end: "20230430", expected: 30)
    }

    func test_period_inside_budget_month() {
        givenBudgets(Budget(yearMonth: "202304", amount: 30))
        totalAmountShouldBe(start: "20230403", end: "20230403", expected: 1)
    }

    func test_period_no_overlap_before_budget_first_day() {
        givenBudgets(Budget(yearMonth: "202304", amount: 30))
        totalAmountShouldBe(start: "20230303", end: "20230303", expected: 0)
    }

    func test_period_no_overlap_after_budget_last_day() {
        givenBudgets(Budget(yearMonth: "202304", amount: 30))
        totalAmountShouldBe(start: "20230503", end: "20230503", expected: 0)
    }


    private func givenBudgets(_ budgets: Budget...) {
        repo.budgets = budgets
    }

    private func totalAmountShouldBe(start: String, end: String, expected: Double) {
        let startDate = Date(start, format: "yyyyMMdd")
        let endDate = Date(end, format: "yyyyMMdd")
        XCTAssertEqual(budgetService.query(start: startDate, end: endDate), expected)
    }
}

class FakeBudgetRepository: BudgetRepository {
    var budgets: [Budget] = []

    override func getAll() -> [Budget] {
        budgets
    }
}
