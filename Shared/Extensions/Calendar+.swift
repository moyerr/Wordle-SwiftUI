//
//  Calendar+.swift
//  Wordle
//
//  Created by Robert Moyer on 2/7/22.
//

import Foundation

extension Calendar {
  func isDate(_ end: Date, inDayAfter start: Date) -> Bool {
      numberOfDays(from: start, to: end) == 1
  }

  func numberOfDays(from start: Date, to end: Date) -> Int {
    let startOfStartDate = startOfDay(for: start)
    let startOfEndDate = startOfDay(for: end)
    let numberOfDays = dateComponents([.day], from: startOfStartDate, to: startOfEndDate)

    return numberOfDays.day!
  }
}
