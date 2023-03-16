//
//  SwiftBudgeTests.swift
//  SwiftBudgeTests
//
//  Created by chantil on 2023/3/15.
//

import XCTest
@testable import SwiftBudge

final class SwiftBudgeTests: XCTestCase {
    let budgetService = BudgetService()

    func test_no_budgets() {
        let startDate = Date("20230401", format: "yyyyMMdd")
        let endDate = Date("20230403", format: "yyyyMMdd")
        XCTAssertEqual(budgetService.query(start: startDate, end: endDate), 0)
    }
}
