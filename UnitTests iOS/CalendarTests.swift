//
//  CalendarTests.swift
//  Tests iOS
//
//  Created by Robert Moyer on 2/7/22.
//

@testable import Wordle
import XCTest

class CalendarTests: XCTestCase {
  private let calendar = Calendar(identifier: .gregorian)

  func testDayAfter() {
    let today = Date()
    let tomorrow = calendar.date(byAdding: .day, value: 1, to: today)!
    let theNextDay = calendar.date(byAdding: .day, value: 1, to: tomorrow)!

    XCTAssertTrue(calendar.isDate(tomorrow, inDayAfter: today))
    XCTAssertFalse(calendar.isDate(theNextDay, inDayAfter: today))
    XCTAssertTrue(calendar.isDate(theNextDay, inDayAfter: tomorrow))
  }

  func testNumberOfDays() throws {
    let today = Date()
    let tomorrow = calendar.date(byAdding: .day, value: 1, to: today)!
    let yesterday = calendar.date(byAdding: .day, value: -1, to: today)!
    let nextWeek = calendar.date(byAdding: .day, value: 7, to: today)!

    XCTAssertEqual(calendar.numberOfDays(from: today, to: tomorrow), 1)
    XCTAssertEqual(calendar.numberOfDays(from: yesterday, to: today), 1)
    XCTAssertEqual(calendar.numberOfDays(from: today, to: nextWeek), 7)
  }

}
