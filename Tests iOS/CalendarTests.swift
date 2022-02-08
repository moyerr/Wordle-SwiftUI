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

  func testNumberOfDays() throws {
    let now = Date()
    let tomorrow = calendar.date(byAdding: .day, value: 1, to: now)!
    let yesterday = calendar.date(byAdding: .day, value: -1, to: now)!
    let nextWeek = calendar.date(byAdding: .day, value: 7, to: now)!

    XCTAssertEqual(calendar.numberOfDays(from: now, to: tomorrow), 1)
    XCTAssertEqual(calendar.numberOfDays(from: yesterday, to: now), 1)
    XCTAssertEqual(calendar.numberOfDays(from: now, to: nextWeek), 7)
  }

}
