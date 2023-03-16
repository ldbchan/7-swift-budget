//
//  BudgetService.swift
//  SwiftBudge
//
//  Created by chantil on 2023/3/15.
//

import Foundation

class BudgetService {
    let repository: BudgetRepository
    var allBudgets: [Budget] = []

    init(repository: BudgetRepository) {
        self.repository = repository
    }

    func query(start: Date, end: Date) -> Double {
        allBudgets = repository.getAll()

        guard isValid(start: start, end: end) else {
            return 0
        }

        if isSameMonth(start: start, end: end) {
            let period = Period(start: start, end: end)
            return getBudget(days: period.days(), date: start)
        } else {
            var amount = 0.0
            var currentMonth = start

            while currentMonth.month() <= end.month() {
                if let budget = allBudgets.first(where: { $0.yearMonth == currentMonth.toYearMonth() }) {
                    var overlappingStart: Date
                    var overlappingEnd: Date

                    if budget.yearMonth == start.toYearMonth() {
                        overlappingStart = start
                        overlappingEnd = budget.lastDay()
                    }
                    else if budget.yearMonth == end.toYearMonth() {
                        overlappingStart = budget.firstDay()
                        overlappingEnd = end
                    }
                    else {
                        overlappingStart = budget.firstDay()
                        overlappingEnd = budget.lastDay()
                    }
                    let period = Period(start: overlappingStart, end: overlappingEnd)
                    amount += budget.dailyAmount() * Double(period.days())
                }

                currentMonth = currentMonth.nextMonth()
            }
            return amount
        }
    }

    func isValid(start: Date, end: Date) -> Bool {
        start <= end
    }

    // MARK: Month

    func isSameMonth(start: Date, end: Date) -> Bool {
        let calendar = Calendar.current
        let startComponents = calendar.dateComponents([.year, .month], from: start)
        let endComponents = calendar.dateComponents([.year, .month], from: end)
        return startComponents.year == endComponents.year && startComponents.month == endComponents.month
    }

    func daysInMonth(_ date: Date) -> Int {
        let calendar = Calendar.current
        let interval = calendar.dateInterval(of: .month, for: date)!
        return calendar.dateComponents([.day], from: interval.start, to: interval.end).day!
    }

    func remainDaysInMonth(_ date: Date) -> Int {
        let totalDays = daysInMonth(date)
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: date)
        return totalDays - components.day! + 1
    }

    func partialDaysInMonth(_ date: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: date)
        return components.day!
    }

    // MARK: Budget

    func getMonthBudget(_ month: YearMonth) -> Double {
        Double(allBudgets.first(where: { $0.yearMonth == month })?.amount ?? 0)
    }

    func getBudget(days: Int, date: Date) -> Double {
        getMonthBudget(date.toYearMonth()) * Double(days) / Double(date.lengthOfMonth())
    }
}

extension Date {
    func lengthOfMonth() -> Int {
        let calendar = Calendar.current
        let interval = calendar.dateInterval(of: .month, for: self)!
        return calendar.dateComponents([.day], from: interval.start, to: interval.end).day!
    }

    func toYearMonth() -> YearMonth {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMM"
        return dateFormatter.string(from: self)
    }

    func month() -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.month], from: self)
        return components.month!
    }

    func nextMonth() -> Date {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month], from: self)
        components.month = components.month! + 1
        return calendar.date(from: components)!
    }

    func firstDayInMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }

    func lastDayInMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: firstDayInMonth())!

    }
}
