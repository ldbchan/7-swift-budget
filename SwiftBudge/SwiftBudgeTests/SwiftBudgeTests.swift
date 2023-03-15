//
//  SwiftBudgeTests.swift
//  SwiftBudgeTests
//
//  Created by chantil on 2023/3/15.
//

import XCTest
@testable import SwiftBudge

final class SwiftBudgeTests: XCTestCase {

    var budgetRepository: BudgetRepository!
    var budgetService: BudgetService!

    override func setUp() {
        super.setUp()

        budgetRepository = FakeBudgetRepository()
        budgetService = BudgetService(repository: budgetRepository)
    }

    func test_query_whole_month() {
        let start = Date.date(string: "20230101")
        let end = Date.date(string: "20230131")
        XCTAssertEqual(budgetService.query(start: start, end: end), 310)
    }

    func test_query_partial_month() {
        let start = Date.date(string: "20230101")
        let end = Date.date(string: "20230101")
        XCTAssertEqual(budgetService.query(start: start, end: end), 10)
    }
}

struct FakeBudgetRepository: BudgetRepository {
    func getAll() -> [Budget] {
        [
            Budget(yearMonth: "202301", amount: 310),
            Budget(yearMonth: "202302", amount: 2800),
        ]
    }
}

extension Date {
    static func date(string: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        return dateFormatter.date(from: string)!
    }
}
