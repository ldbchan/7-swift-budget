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
            let days = numberOfDaysBetween(start, end)
            return Double(
                getBudgets(days: days, date: start)
            )
        } else {
            let firstMonthDays = remainDaysInMonth(start)
            let lastMonthDays = partialDaysInMonth(end)
            var amount: Double = getBudgets(days: firstMonthDays, date: start) + getBudgets(days: lastMonthDays, date: end)

            var currentMonth = start.nextMonth()
            while currentMonth.month() < end.month() {
                amount += getMonthBudget(currentMonth.toYearMonth())
                currentMonth = currentMonth.nextMonth()
            }
            return Double(amount)
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

    func numberOfDaysBetween(_ start: Date, _ end: Date) -> Int {
        let numberOfDays = Calendar.current.dateComponents([.day], from: start, to: end)
        return numberOfDays.day! + 1
    }

    // MARK: Budget

    func getMonthBudget(_ month: YearMonth) -> Double {
        Double(allBudgets.first(where: { $0.yearMonth == month })?.amount ?? 0)
    }

    func getBudgets(days: Int, date: Date) -> Double {
        let monthDays = daysInMonth(date)
        let percentage = Double(days) / Double(monthDays)
        return getMonthBudget(date.toYearMonth()) * percentage
    }

}

extension Date {
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
}
