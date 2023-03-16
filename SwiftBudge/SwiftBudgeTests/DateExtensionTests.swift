//
//  DateExtensionTests.swift
//  SwiftBudgeTests
//
//  Created by chantil on 2023/3/16.
//

import XCTest
@testable import SwiftBudge

class DateExtensionTests: XCTestCase {
    func test_lengthOfMonth() {
        XCTAssertEqual(Date("20220301", format: "yyyyMMdd").lengthOfMonth(), 31)
        XCTAssertEqual(Date("202204", format: "yyyyMM").lengthOfMonth(), 30)
    }

    func test_firstDayOfMonth() {
        XCTAssertEqual(Date("20220301", format: "yyyyMMdd").firstDayOfMonth().toString("yyyyMMdd"), "20220301")
        XCTAssertEqual(Date("202204", format: "yyyyMM").firstDayOfMonth().toString("yyyyMMdd"), "20220401")
    }

    func test_lastDayOfMonth() {
        XCTAssertEqual(Date("20220301", format: "yyyyMMdd").lastDayOfMonth().toString("yyyyMMdd"), "20220331")
        XCTAssertEqual(Date("202204", format: "yyyyMM").lastDayOfMonth().toString("yyyyMMdd"), "20220430")

    }
}
