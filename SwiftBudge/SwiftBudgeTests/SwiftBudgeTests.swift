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

    func test_query_cross_month() {
        let start = Date.date(string: "20230131")
        let end = Date.date(string: "20230202")
        XCTAssertEqual(budgetService.query(start: start, end: end), 210)
    }

    func test_query_no_month_budget() {
        let start = Date.date(string: "20230301")
        let end = Date.date(string: "20230301")
        XCTAssertEqual(budgetService.query(start: start, end: end), 0)
    }

    func test_query_invalid_date() {
        let start = Date.date(string: "20230228")
        let end = Date.date(string: "20230201")
        XCTAssertEqual(budgetService.query(start: start, end: end), 0)
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
